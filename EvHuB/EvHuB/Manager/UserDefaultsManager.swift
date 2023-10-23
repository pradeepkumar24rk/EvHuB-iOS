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
    
    func getUserDefaultsValue(key: String) -> String {
        if let val = UserDefaults.standard.string(forKey: key) {
            return val
        }
        return ""
    }
    
    func setUserDefaultsValue(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    var locationAddresses: String {
        get {
            return getUserDefaultsValue(key: address)
        }
        set {
            setUserDefaultsValue(key: address, value: newValue)
        }
    }
}
