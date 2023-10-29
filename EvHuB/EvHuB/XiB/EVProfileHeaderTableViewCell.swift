//
//  EVProfileHeaderTableViewCell.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 28/10/23.
//

import UIKit

class EVProfileHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    static let identifier = "EVProfileHeaderTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "EVProfileHeaderTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileView.designView()
    }
    
    func config(name: String?) {
        if let val = name {
            userNameLabel.text = val
        }
    }
}
