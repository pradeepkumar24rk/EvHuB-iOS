//
//  EVTableViewCell.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 27/10/23.
//

import UIKit

class EVTableViewCell: UITableViewCell {

    @IBOutlet weak var rowLabel: UILabel!
    
    static let identifier = "EVTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "EVTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ data: String) {
        rowLabel.text = data
    }
    
}
