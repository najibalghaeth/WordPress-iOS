import Foundation



class BlogService {

    init(managedObjectContext: NSManagedObjectContext) {

    }

    func blogCountForAllAccounts() -> Int {
        return 0
    }

    func fetchSiteInfo(forAddress: String, success: (SiteInfo) -> Void, failure: (Error) -> Void) {
        
    }

    func findBlog(withXmlrpc: String, andUsername: String) -> Blog? {
        return nil
    }

    func associateSyncedBlogs(toJetpackAccount: WPAccount, success: ()-> Void, failure: (Error) -> Void) {

    }
}
