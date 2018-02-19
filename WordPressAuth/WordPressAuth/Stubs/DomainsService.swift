import Foundation
import CoreData
import WordPressKit

class DomainsService {

    init(managedObjectContext context: NSManagedObjectContext, remote: DomainsServiceRemote) {
    }

    func getDomainSuggestions(base: String, success: @escaping ([String]) -> Void, failure: @escaping (Error) -> Void) {

    }
}
