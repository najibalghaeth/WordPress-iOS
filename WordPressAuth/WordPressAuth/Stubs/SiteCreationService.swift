import Foundation
import CocoaLumberjack
import WordPressShared


enum SiteCreationStatus: Int {
    case validating
    case gettingDefaultAccount
    case creatingSite
    case settingTagline
    case settingTheme
    case syncing
}

struct SiteCreationParams {
    var siteUrl: String
    var siteTitle: String
    var siteTagline: String?
    var siteTheme: Theme?

    init(siteUrl: String, siteTitle: String, siteTagline: String? = nil, siteTheme: Theme? = nil) {
        self.siteUrl = siteUrl
        self.siteTitle = siteTitle
        self.siteTagline = siteTagline
        self.siteTheme = siteTheme
    }
}

typealias SiteCreationStatusBlock = (_ status: SiteCreationStatus) -> Void
typealias SiteCreationSuccessBlock = () -> Void
typealias SiteCreationRequestSuccessBlock = (_ blog: Blog) -> Void
typealias SiteCreationFailureBlock = (_ error: Error?) -> Void
private var taglineBlock: (() -> Void)?
private var themeBlock: (() -> Void)?
private var syncBlock: (() -> Void)?


class SiteCreationService {

    init(managedObjectContext: NSManagedObjectContext) {

    }
    
    func createSite(siteURL url: String,
                    siteTitle: String,
                    siteTagline: String?,
                    siteTheme: Theme?,
                    status: @escaping SiteCreationStatusBlock,
                    success: @escaping SiteCreationRequestSuccessBlock,
                    failure: @escaping SiteCreationFailureBlock) {

    }

    func validateWPComBlogWithParams(_ params: SiteCreationParams,
                                     status: SiteCreationStatusBlock,
                                     success: @escaping SiteCreationSuccessBlock,
                                     failure: @escaping SiteCreationFailureBlock) {

    }

    func createWPComBlogForParams(_ params: SiteCreationParams,
                                  account: WPAccount,
                                  status: SiteCreationStatusBlock,
                                  success: @escaping (_ blog: Blog) -> Void,
                                  failure: @escaping SiteCreationFailureBlock) {

    }

    func updateAndSyncBlogAndAccountInfo(_ blog: Blog,
                                         status: SiteCreationStatusBlock,
                                         success: @escaping SiteCreationSuccessBlock,
                                         failure: @escaping SiteCreationFailureBlock) {

    }

    func setWPComBlogTagline(blog: Blog,
                             params: SiteCreationParams,
                             status: SiteCreationStatusBlock,
                             success: @escaping SiteCreationSuccessBlock,
                             failure: @escaping SiteCreationFailureBlock) {

    }

    func setWPComBlogTheme(blog: Blog,
                           params: SiteCreationParams,
                           status: SiteCreationStatusBlock,
                           success: @escaping SiteCreationSuccessBlock,
                           failure: @escaping SiteCreationFailureBlock) {

    }

    func retryFromTagline() {

    }

    func retryFromTheme() {

    }

    func retryFromAccountSync() {

    }

    // MARK: - WP API


    /// A convenience enum for creating meaningful NSError objects.
    private enum SiteCreationError: Error {
        case invalidResponse
        case missingRESTAPI
        case missingDefaultWPComAccount
        case missingTheme
    }

    /// A convenience struct for Blog keys
    private struct BlogKeys {
        static let blogDetails = "blog_details"
        static let blogNameLowerCaseN = "blogname"
        static let blogNameUpperCaseN = "blogName"
        static let XMLRPC = "xmlrpc"
        static let blogID = "blogid"
        static let URL = "url"
    }

}

