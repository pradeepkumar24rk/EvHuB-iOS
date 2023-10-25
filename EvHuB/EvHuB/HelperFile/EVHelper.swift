//
//  EVHelper.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation

class EVHelper {
    static let shared = EVHelper()
    
    func isValidEmail(check email: String) -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}", options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        return emailRegex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func isValidPassword(check password: String) -> Bool {
        let mininumCharater = 6
        let hasUpperCase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowerCase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasSpecialCharacter = password.rangeOfCharacter(from: CharacterSet(charactersIn: "$!#%^&*?><+-_@")) != nil
        return password.count >= mininumCharater && hasUpperCase && hasLowerCase && hasSpecialCharacter
    }
}
