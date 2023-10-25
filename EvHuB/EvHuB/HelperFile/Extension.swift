//
//  Extension.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation
import UIKit

extension UIView {
    func designView() {
        self.layer.borderColor = UIColor(red: 0.64, green: 0.38, blue: 0.91, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 12
        self.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16).cgColor
    }
}

extension UITextField {
    func designTextField() {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    func designButton(title: String, changeColorText: String) {
        let attribute = NSMutableAttributedString(string: title)
        let textColor = UIColor(red: 0.639, green: 0.384, blue: 0.914, alpha: 1)
        if let range = title.range(of: changeColorText) {
            attribute.addAttribute(.foregroundColor, value: textColor, range: NSRange(range, in: title))
        }
        self.setAttributedTitle(attribute, for: .normal)
    }
}
