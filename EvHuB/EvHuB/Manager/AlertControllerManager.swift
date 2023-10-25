//
//  AlertControllerManager.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import Foundation

import Foundation
import UIKit

class AlertControllerManager {
    
    static let shared = AlertControllerManager()
    
    func showAlert(on viewController: UIViewController, title: String, message: String, disableCancel: Bool = false, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style: .default, handler: { _ in
            completion?()
        }))
        if !disableCancel {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        viewController.present(alert, animated: true)
    }
    
    func showAlertWithTextField(on viewController: UIViewController, title: String, message: String, textFieldPlaceHolder: String, actionName: String,disableCancel: Bool = false, completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = textFieldPlaceHolder
            textfield.addTarget(self, action: #selector(AlertControllerManager.handleAlterTextField(_:)), for: .editingChanged)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: actionName, style: .default, handler: { _ in
            if let textField = alert.textFields?.first, let enteredText = textField.text {        // get the first textfield value
                completion(enteredText)
            } else {
                completion(nil)
            }
        })
        submitAction.isEnabled = false
        if !disableCancel {
            alert.addAction(cancelAction)
        }
        alert.addAction(submitAction)
        viewController.present(alert, animated: true)
    }
    
    @objc static func handleAlterTextField(_ textfield: UITextField) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let alertController = windowScene.windows.first?.rootViewController?.presentedViewController as? UIAlertController,
           let actionName = alertController.actions.last?.title,
           let okAction = alertController.actions.first(where: { $0.title == actionName }) {
            okAction.isEnabled = textfield.hasText   //If the field has the value then enable the button
        }
    }
}
