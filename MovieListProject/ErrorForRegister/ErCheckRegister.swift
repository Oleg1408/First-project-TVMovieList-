import Foundation

class ErCheckRegister {
    
    static func isFilledRegister(name: String?, secondName: String?, email: String?, password: String?) -> Bool {
        
        guard !(name ?? "").isEmpty,
              !(secondName ?? "").isEmpty,
              !(email ?? "").isEmpty,
              !(password ?? "").isEmpty
        else {
            return false
        }
        return true
    }
    
    static func checkEmailForRegister(_ email: String?) -> Bool {
        let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_'{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return check(text: email, regex: emailRegex)
    }
    
    private static func check(text: String?, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}
