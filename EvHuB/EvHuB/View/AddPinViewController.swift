//
//  AddPinViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 21/10/23.
//

import UIKit

protocol AddPinDelegate {
    func addPin(_ data: HubModel)
}

class AddPinViewController: UIViewController {
    @IBOutlet weak var titleLable: UITextField!
    @IBOutlet weak var address: UITextView!
    
    var delegate: AddPinDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitBtnHandler(_ sender: Any) {
        let data = HubModel(name: titleLable.text ?? "", address: address.text ?? "")
        delegate?.addPin(data)
        self.navigationController?.popViewController(animated: true)
    }
}
