//
//  LaunchScreenViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 25/10/23.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!

    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            // Initial image size and opacity
        gifImageView.alpha = 0.0
        gifImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

            // Animate the image size and opacity
            UIView.animate(withDuration: 3.0, animations: {
                self.gifImageView.transform = .identity
                self.gifImageView.alpha = 1.0
            }) { _ in
                // Animation completion block - navigate to the second view controller
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController")
                self.view.window?.rootViewController = vc
                self.view.window?.makeKeyAndVisible()
            }
        }

}
