import Foundation


extension NSNotification.Name {
    static let HelpshiftUnreadCountUpdated = NSNotification.Name("Something")
}

class HelpshiftUtils {
    static func refreshUnreadNotificationCount() {

    }

    static func unreadNotificationCount() -> Int {
        return 0
    }

    static func isHelpshiftEnabled() -> Bool {
        return false
    }
}
