//
//  ControllerExtension.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import UIKit

extension UIViewController {
    func showAlert() {
        let alertViewController = UIAlertController(title:"Error", message:"Something went wrong, Pls try again!", preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title:"Ok", style: UIAlertAction.Style.cancel, handler: { (alert) in
            alertViewController.dismiss(animated:true, completion:nil)
        })
        alertViewController.addAction(alertAction)
        self.present(alertViewController, animated:true, completion:nil)
    }
}
