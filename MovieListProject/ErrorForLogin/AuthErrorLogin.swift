import Foundation

enum AuthErrorLogin {
    case notField
    case invalidEmail
    case unknowError
    case serverError
}

extension AuthErrorLogin: LocalizedError {
    var errorDescription: String? {
        
        switch self {
        case .notField:
            return NSLocalizedString("Please, fill in all fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email is not valid", comment: "")
        case .unknowError:
            return NSLocalizedString("Unknow Error", comment: "")
        case .serverError:
            return NSLocalizedString("Server Error", comment: "")
        }
    }
}
