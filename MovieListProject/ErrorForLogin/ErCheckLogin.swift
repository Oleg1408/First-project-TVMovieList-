//
//  ErCheckLogin.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 01.10.2022.
//

import Foundation

class ErCheckLogin {
    
    static func isFilledLogin(email: String?, password: String?) -> Bool {
        
        guard !(email ?? "").isEmpty,
              !(password ?? "").isEmpty
        else {
            return false
        }
        return true
    }
    
    static func checkEmailForLogin(_ email: String?) -> Bool {
        let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_'{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return check(text: email, regex: emailRegex)
    }
    
    private static func check(text: String?, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}
