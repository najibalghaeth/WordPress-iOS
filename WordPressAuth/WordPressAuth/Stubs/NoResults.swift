import Foundation
import UIKit


protocol NoResultsViewControllerDelegate: class {
    
}


class NoResultsViewController: UIViewController {

    weak var delegate: NoResultsViewControllerDelegate?

    func configure(title: String, buttonTitle: String, subtitle: String?, image: String) {

    }

    func showDismissButton() {

    }

    func addWordPressLogoToNavController() {

    }
}
