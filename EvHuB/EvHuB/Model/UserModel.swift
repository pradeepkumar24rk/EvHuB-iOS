//
//  UserModel.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation

struct UserModel: Codable {
    var email = String()
    var password = String()
    var admin = false
}
