import Foundation

class SignupService {
    init(managedObjectContext: NSManagedObjectContext) {

    }

    func createBlogAndSigninToWPCom(blogURL: String, blogTitle: String, emailAddress: String, username: String, password: String, status: ((SignupStatus) -> Void), success: () -> (), failure: ((Error) -> ())) {

    }
}
