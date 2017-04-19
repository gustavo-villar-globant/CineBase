import Foundation

protocol UserBasicInfo {
    var providerID: String { get }
    var uid: String { get }
    var displayName: String? { get }
    var photoURL: URL? { get }
    var email: String? { get }
}
