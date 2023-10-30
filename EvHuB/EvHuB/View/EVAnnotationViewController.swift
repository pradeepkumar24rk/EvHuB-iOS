//
//  EVAnnotationViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 29/10/23.
//

import UIKit

class EVAnnotationViewController: UIViewController {
    
    @IBOutlet weak var timeOfCharging: UITextField!
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var addressLable: UILabel!
    
    var hubInfo: HubModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let val = hubInfo else { return }
        self.navigationItem.title = val.name
        self.navigationItem.largeTitleDisplayMode = .always
        addressLable.text = val.address
        timeOfCharging.addTarget(self, action: #selector(priceForPayment), for: .editingChanged)
    }
    
    @objc func priceForPayment() {
        if let time = timeOfCharging.text, let hubprice = hubInfo?.amountOfChargerPerMin {
            let price = (Int(time) ?? 0) * hubprice
            paymentBtn.setTitle("Payment Rs.\(price)", for: .normal)
        }
    }
    
    @IBAction func paymentBtnHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentSuccessViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
