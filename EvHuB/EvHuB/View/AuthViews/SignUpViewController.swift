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
    var userInfo: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        signUpBtn.layer.cornerRadius = 20
        loginBtn.designButton(title: "Already have an account? Login", changeColorText: "Login")
        username.designTextField()
        password.designTextField()
        password.isSecureTextEntry = true
    }
    @IBAction func signUpBtnHandler(_ sender: Any) {
        userInfo?.email = username.text ?? ""
        userInfo?.password = password.text ?? ""
        if signUpViewModel.signUpValidation(check: userInfo ?? UserModel()) {
            signUpViewModel.addNewUser(newUser: userInfo ?? UserModel())
            print("added")
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
            vc.userInfo = self.userInfo
            let navcontroller = UINavigationController(rootViewController: vc)
            self.view.window?.rootViewController = navcontroller
            self.view.window?.makeKeyAndVisible()
        } else {
            alertControllerManager.showAlert(on: self, title: "Invalid", message: signUpViewModel.message, disableCancel: true)
        }
    }
    
    @IBAction func loginBtnHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
