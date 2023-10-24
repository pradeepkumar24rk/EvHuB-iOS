//
//  AddPinViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 21/10/23.
//

import UIKit

protocol AddPinDelegate {
    func addPin(_ data: String)
}

class AddPinViewController: UIViewController {
    @IBOutlet weak var address: UITextView!
    
    var delegate: AddPinDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitBtnHandler(_ sender: Any) {
        delegate?.addPin(address.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}
