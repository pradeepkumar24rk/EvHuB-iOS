//
//  UserDefaultsManager.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 23/10/23.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    private let address = "ListOfAddress"
    private let usersData = "Users"
    
    func getUserDefaultsValue(key: String) -> [String] {
        if let val = UserDefaults.standard.value(forKey: key) as? [String] {
            return val
        }
        return []
    }
    
    func setUserDefaultsValue(key: String, value: [String]) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func setUserDict(key: String,_ newValue: [String: [UserModel]]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: key)
    }
    
    func getUserDict(key: String) -> [String: [UserModel]] {
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
           let decodedValue = try? PropertyListDecoder().decode([String: [UserModel]].self, from: data) {
            return decodedValue
        }
        return ["": [UserModel]()]
    }
    
    var locationAddresses: [String] {
        get {
            return getUserDefaultsValue(key: address)
        }
        set {
            setUserDefaultsValue(key: address, value: newValue)
        }
    }
    
    var users: [UserModel] {
        get {
            if let users = getUserDict(key: usersData)["users"] {
                return users
            }
            return []
        }
        set {
            setUserDict(key: usersData,["users": newValue])
        }
    }
}
