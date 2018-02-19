import Foundation


class Theme {
    var screenshotUrl: String?
    var name = ""
}


class ThemeService {

    init(managedObjectContext: NSManagedObjectContext) {

    }

    func getStartingThemes(forCategory: String, page: Int, success: (([Theme]?, Bool, NSInteger) -> Void), failure: ((Error?) -> Void)) {

    }
}
