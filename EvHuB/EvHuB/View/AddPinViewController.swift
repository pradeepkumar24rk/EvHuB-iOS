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
    @IBOutlet weak var chargingPrice: UITextField!
    
    var delegate: AddPinDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitBtnHandler(_ sender: Any) {
        if let title = titleLable.text, let address = address.text, let price = Int(chargingPrice.text ?? "0") {
            let data = HubModel(name: title, address: address, amountOfChargerPerMin: price)
            delegate?.addPin(data)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
