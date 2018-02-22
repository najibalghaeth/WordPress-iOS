import Foundation


@objc
enum SupportSourceTag: Int {
    case login2FA
    case jetpackLogin
    case generalLogin
    case loginEmail
    case wpComSignupEmail
    case wpComSignup
    case loginUsernamePassword
    case loginMagicLink
    case loginSiteAddress
    case loginWPComPassword
    
    static func ==(lhs: SupportSourceTag, rhs: SupportSourceTag) -> Bool {
        return false
    }
}


class SupportViewController: UIViewController {
    var sourceTag: SupportSourceTag?
    var helpshiftOptions: [String: Any]?
}


extension WordPressSupportSourceTag {
    func toSupportSourceTag() -> SupportSourceTag {
        return .loginWPComPassword
    }
}
