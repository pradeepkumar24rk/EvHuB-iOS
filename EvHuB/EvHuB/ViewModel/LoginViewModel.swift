//
//  LoginViewModel.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation

class LoginViewModel {
    var userDefaults = UserDefaultsManager.shared
    var message = String()
    var userIndex = Int()
    
    func FindingUser(emailId: String, password: String) -> Bool {
        if loginValidation(emailId: emailId, password: password) {
            if let index = userDefaults.users.firstIndex(where: { data in
                data.email == emailId
            }){
                if !(userDefaults.users[index].password == password) {
                    message = "Password is wrong."
                    return false
                }
                userIndex = index
                return true
            }
            message = "No user found "
        }
        return false
    }
    
    func loginValidation(emailId: String, password: String) -> Bool {
        if !isRequiredFieldFilled(emailId: emailId, password: password) {
            return false
        } else if !EVHelper.shared.isValidEmail(check: emailId) {
            message = "Please Enter the valid EmailId"
            return false
        } else if !EVHelper.shared.isValidPassword(check: password) {
            message = "Please Enter the valid Password.\nPassword should have 6 character length, 1 special character, 1 number and 1 capital letter"
            return false
        }
        return true
    }
    
    func isRequiredFieldFilled(emailId: String, password: String) -> Bool {
        if (emailId == "") && (password == "") {
            message = "Please Enter the emailId and password."
            return false
        } else if (emailId == "") {
            message = "Please Enter the email."
            return false
        } else if (password == "") {
            message = "Please Enter the password."
            return false
        }
        return true
    }
}

