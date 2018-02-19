import Foundation

public class WordPressAuthenticator {

    static let shared = WordPressAuthenticator()
    var delegate: WordPressAuthenticatorDelegate?
}


protocol WordPressAuthenticatorDelegate {

}


extension NSNotification.Name {
    static let wordpressAuthenticationEvent = NSNotification.Name(rawValue: "WordPressAuthenticatorEvent")
}


extension WordPressAuthenticator {
    public enum Event {
        case createAccountInitiated
        case loginAutoFillCredentialsFilled
        case loginAutoFillCredentialsUpdated
        case loginEmailFormViewed
        case loginEpilogueViewed
        case loginFailed(error: Error)
        case loginFailedToGuessXMLRPC(error: Error)
        case loginForgotPasswordClicked
        case loginMagicLinkFailed
        case loginMagicLinkOpenEmailClientViewed
        case loginMagicLinkRequested
        case loginMagicLinkRequestFormViewed
        case loginMagicLinkExited
        case loginMagicLinkOpened
        case loginMagicLinkSucceeded
        case loginPasswordFormViewed
        case loginProloguePaged
        case loginPrologueViewed
        case loginSocialAccountsNeedConnecting
        case loginSocial2faNeeded
        case loginSocialButtonClick
        case loginSocialButtonFailure
        case loginSocialConnectSuccess
        case loginSocialConnectFailure(error: Error)
        case loginSocialErrorUnknownUser
        case loginSocialSuccess
        case loginTwoFactorFormViewed
        case loginURLFormViewed
        case loginUsernamePasswordFormViewed
        case onePasswordFailed
        case onePasswordLogin
        case openedLogin
        case signupMagicLinkOpenEmailClientViewed
        case twoFactorCodeRequested
    }
}

extension WordPressAuthenticator {
    static func emit(event: Event) {
        NotificationCenter.default.post(name: .wordpressAuthenticationEvent, object: event)
    }
}
