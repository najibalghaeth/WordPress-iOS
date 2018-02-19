public struct ImmuTable {
    /// An array of the sections to be represented in the table view
    public let sections: [ImmuTableSection]

    /// Initializes an ImmuTable object with the given sections
    public init(sections: [ImmuTableSection]) {
        self.sections = sections
    }

    /// Returns the row model for a specific index path.
    ///
    /// - Precondition: `indexPath` should represent a valid section and row, otherwise this method
    ///                 will raise an exception.
    ///
    public func rowAtIndexPath(_ indexPath: IndexPath) -> ImmuTableRow {
        return sections[indexPath.section].rows[indexPath.row]
    }

    /// Registers the row custom class or nib with the table view so it can later be
    /// dequeued with `dequeueReusableCellWithIdentifier(_:forIndexPath:)`
    ///
    public static func registerRows(_ rows: [ImmuTableRow.Type], tableView: UITableView) {
        registerRows(rows, registrator: tableView)
    }

    /// This function exists for testing purposes
    /// - seealso: registerRows(_:tableView:)
    internal static func registerRows(_ rows: [ImmuTableRow.Type], registrator: CellRegistrator) {
        let registrables = rows.reduce([:]) {
            (classes, row) -> [String: ImmuTableCell] in

            var classes = classes
            classes[row.cell.reusableIdentifier] = row.cell
            return classes
        }
        for (identifier, registrable) in registrables {
            registrator.register(registrable, cellReuseIdentifier: identifier)
        }
    }
}

extension ImmuTable {
    /// Alias for an ImmuTable with no sections
    static var Empty: ImmuTable {
        return ImmuTable(sections: [])
    }
}


public struct ImmuTableSection {
    let headerText: String?
    let rows: [ImmuTableRow]
    let footerText: String?

    /// Initializes a ImmuTableSection with the given rows and optionally header and footer text
    public init(headerText: String? = nil, rows: [ImmuTableRow], footerText: String? = nil) {
        self.headerText = headerText
        self.rows = rows
        self.footerText = footerText
    }
}

public protocol ImmuTableRow {

    var action: ImmuTableAction? { get }

    func configureCell(_ cell: UITableViewCell)

    static var cell: ImmuTableCell { get }

    static var customHeight: Float? { get }
}

extension ImmuTableRow {
    public var reusableIdentifier: String {
        return type(of: self).cell.reusableIdentifier
    }

    public var cellClass: UITableViewCell.Type {
        return type(of: self).cell.cellClass
    }

    public static var customHeight: Float? {
        return nil
    }
}


// MARK: - ImmuTableCell


/// ImmuTableCell describes cell types so they can be registered with a table view.
///
/// It supports two options:
///    - Nib for Interface Builder defined cells.
///    - Class for cells defined in code.
/// Both cases presume a custom UITableViewCell subclass. If you aren't subclassing,
/// you can also use UITableViewCell as the type.
///
/// - Note: If you need to use any cell style other than .Default we recommend you
///  subclass UITableViewCell and override init(style:reuseIdentifier:).
///
public enum ImmuTableCell {

    /// A cell using a UINib. Values are the UINib object and the custom cell class.
    case nib(UINib, UITableViewCell.Type)

    /// A cell using a custom class. The associated value is the custom cell class.
    case `class`(UITableViewCell.Type)

    /// A String that uniquely identifies the cell type
    public var reusableIdentifier: String {
        switch self {
        case .class(let cellClass):
            return NSStringFromClass(cellClass)
        case .nib(_, let cellClass):
            return NSStringFromClass(cellClass)
        }
    }

    /// The class of the custom cell
    public var cellClass: UITableViewCell.Type {
        switch self {
        case .class(let cellClass):
            return cellClass
        case .nib(_, let cellClass):
            return cellClass
        }
    }
}


// MARK: -


/// ImmuTableViewHandler is a helper to facilitate integration of ImmuTable in your
/// table view controllers.
///
/// It acts as the table view data source and delegate, and signals the table view to
/// reload its data when the underlying model changes.
///
/// - Note: As it keeps a weak reference to its target, you should keep a strong
///         reference to the handler from your view controller.
///
open class ImmuTableViewHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    @objc unowned let target: UITableViewController

    /// Initializes the handler with a target table view controller.
    /// - postcondition: After initialization, it becomse the data source and
    ///   delegate for the the target's table view.
    @objc public init(takeOver target: UITableViewController) {
        self.target = target
        super.init()

        self.target.tableView.dataSource = self
        self.target.tableView.delegate = self
    }

    /// An ImmuTable object representing the table structure.
    open var viewModel = ImmuTable.Empty {
        didSet {
            if target.isViewLoaded {
                target.tableView.reloadData()
            }
        }
    }

    /// Configure the handler to automatically deselect any cell after tapping it.
    @objc var automaticallyDeselectCells = false

    // MARK: Table View Data Source

    open func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.rowAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reusableIdentifier, for: indexPath)

        row.configureCell(cell)

        return cell
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].headerText
    }

    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.sections[section].footerText
    }

    // MARK: Table View Delegate

    open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if target.responds(to: #selector(UITableViewDelegate.tableView(_:willSelectRowAt:))) {
            return target.tableView(tableView, willSelectRowAt: indexPath)
        } else {
            return indexPath
        }
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if target.responds(to: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) {
            target.tableView(tableView, didSelectRowAt: indexPath)
        } else {
            let row = viewModel.rowAtIndexPath(indexPath)
            row.action?(row)
        }
        if automaticallyDeselectCells {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = viewModel.rowAtIndexPath(indexPath)
        if let customHeight = type(of: row).customHeight {
            return CGFloat(customHeight)
        }
        return tableView.rowHeight
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}


// MARK: - Type aliases

public typealias ImmuTableAction = (ImmuTableRow) -> Void


// MARK: - Internal testing helpers

protocol CellRegistrator {
    func register(_ cell: ImmuTableCell, cellReuseIdentifier: String)
}


extension UITableView: CellRegistrator {
    public func register(_ cell: ImmuTableCell, cellReuseIdentifier: String) {
        switch cell {
        case .nib(let nib, _):
            self.register(nib, forCellReuseIdentifier: cell.reusableIdentifier)
        case .class(let cellClass):
            self.register(cellClass, forCellReuseIdentifier: cell.reusableIdentifier)
        }
    }
}

