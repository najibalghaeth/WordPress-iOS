import Foundation


enum Feature {
    case socialSignup

    static func enabled(_ feature: Feature) -> Bool {
        return false
    }
}
