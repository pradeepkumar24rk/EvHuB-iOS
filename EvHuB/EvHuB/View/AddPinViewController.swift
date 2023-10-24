//
//  AddPinViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 21/10/23.
//

import UIKit

class AddPinViewController: UIViewController {
    @IBOutlet weak var address: UITextView!
    
    let userDefaults = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitBtnHandler(_ sender: Any) {
        userDefaults.locationAddresses.append(address.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}
