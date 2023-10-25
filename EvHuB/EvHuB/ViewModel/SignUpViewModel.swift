//
//  SignUpViewModel.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation

class SignUpViewModel {
    
    let userDefaults = UserDefaultsManager.shared
    var lastUser = Int()
    var message = String()
    
    func signUpValidation(check data: UserModel) -> Bool {
        if !isRequiredFieldFilled(check: data) {
            message = "Please fill the Required field"
            return false
        } else if !EVHelper.shared.isValidEmail(check: data.email) {
            message = "Please Enter the valid Email"
            return false
        } else if !EVHelper.shared.isValidPassword(check: data.password) {
            message = "Please Enter the valid Password.\nPassword should have 6 character length, 1 special character, 1 number and 1 capital letter"
            return false
        } else if isAlreadyUserAvailable(check: data) {
            message = "Email id is already exist"
            return false
        }
        message = "User is created successfully"
        return true
    }
    
    func isRequiredFieldFilled(check data: UserModel) -> Bool {
        if ( (data.email == "") || (data.password == "") ){
            return false
        }
        return true
    }
    
    func isAlreadyUserAvailable(check data: UserModel) -> Bool {
        if let _ = userDefaults.users.firstIndex(where: { defaultsValue in
            data.email == defaultsValue.email
        }) {
            return true
        }
        return false
    }
    
    func addNewUser(newUser: UserModel) {
       userDefaults.users.append(newUser)
        self.lastUser = UserDefaultsManager.shared.users.count - 1
    }
}
