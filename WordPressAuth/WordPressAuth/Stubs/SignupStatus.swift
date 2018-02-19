import Foundation


/// Individual cases represent each step in the signup process.
///
enum SignupStatus: Int {
    case validating
    case creatingUser
    case authenticating
    case creatingBlog
    case syncing
}
