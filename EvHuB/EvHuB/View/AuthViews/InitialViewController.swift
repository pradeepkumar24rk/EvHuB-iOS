//
//  InitialViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func adminBtnHandler(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        vc.userInfo = UserModel(admin: true)
        let nav = UINavigationController(rootViewController: vc)
        self.view.window?.rootViewController = nav
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func userBtnHandler(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        vc.userInfo = UserModel()
        let nav = UINavigationController(rootViewController: vc)
        self.view.window?.rootViewController = nav
        self.view.window?.makeKeyAndVisible()
    }
}
