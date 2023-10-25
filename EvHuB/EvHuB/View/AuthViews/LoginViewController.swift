//
//  LoginViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let loginViewModel = LoginViewModel()
    let alertControllerManager = AlertControllerManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loginBtn.layer.cornerRadius = 20
        signUpBtn.designButton(title: "Don’t have an account? Sign Up", changeColorText: "Sign Up")
        username.designTextField()
        password.designTextField()
        password.isSecureTextEntry = true
    }
    @IBAction func loginBtnHandler(_ sender: Any) {
        if loginViewModel.FindingUser(emailId: username.text ?? "", password: password.text ?? "") {
//          guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
//            let navcontroller = UINavigationController(rootViewController: vc)
//            self.view.window?.rootViewController = navcontroller
//            self.view.window?.makeKeyAndVisible()
            print("success")
        } else {
            alertControllerManager.showAlert(on: self, title: "Information", message: loginViewModel.message, disableCancel: true)
        }
    }
    
    @IBAction func signUpBtnHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
}
