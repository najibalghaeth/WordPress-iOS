import Foundation

protocol WPContentSyncHelperDelegate: class {

}


class WPContentSyncHelper: NSObject {
    weak var delegate: WPContentSyncHelperDelegate?

    func syncContent() {

    }
}
