import Foundation


class AccountServiceFacade {

    func createOrUpdateWordPressComAccount(withUsername username: String, authToken: String) -> WPAccount {
        return WPAccount()
    }

    func setDefaultWordPressComAccount(_ account: WPAccount) {

    }

    func updateUserDetails(for account: WPAccount, success: () -> (), failure: (Error?) -> ()) {

    }
}
