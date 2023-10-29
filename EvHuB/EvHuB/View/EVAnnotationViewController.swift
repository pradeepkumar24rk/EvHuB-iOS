//
//  EVAnnotationViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 29/10/23.
//

import UIKit

class EVAnnotationViewController: UIViewController {

    @IBOutlet weak var addressLable: UILabel!
    
    var hubInfo: HubModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let val = hubInfo else { return }
        self.navigationItem.title = val.name
        addressLable.text = val.address
    }
    
    @IBAction func paymentBtnHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentSuccessViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
