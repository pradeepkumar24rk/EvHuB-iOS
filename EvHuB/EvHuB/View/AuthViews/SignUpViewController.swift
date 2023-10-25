//
//  SignUpViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    let alertControllerManager = AlertControllerManager.shared
    let signUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBtn.layer.cornerRadius = 20
        loginBtn.designButton(title: "Already have an account? Login", changeColorText: "Login")
        username.designTextField()
        password.designTextField()
        password.isSecureTextEntry = true
    }
    @IBAction func signUpBtnHandler(_ sender: Any) {
        let data = UserModel(email: username.text ?? "", password: password.text ?? "")
        if signUpViewModel.signUpValidation(check: data) {
            signUpViewModel.addNewUser(newUser: data)
            print("added")
//            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
//            vc.indexOfUser = signUpViewModel.lastUser
//            let navcontroller = UINavigationController(rootViewController: vc)
//            self.view.window?.rootViewController = navcontroller
//            self.view.window?.makeKeyAndVisible()
        } else {
            alertControllerManager.showAlert(on: self, title: "Invalid", message: signUpViewModel.message, disableCancel: true)
        }
    }
    
    @IBAction func loginBtnHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
}
