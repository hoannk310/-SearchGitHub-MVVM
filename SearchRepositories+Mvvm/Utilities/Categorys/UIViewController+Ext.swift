//
//  UIViewController+Ext.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 2/23/21.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert (title: String?,
                    message: String?,
                    preferredStype: UIAlertController.Style,
                    actions: UIAlertAction...){
        
        if (self.presentedViewController as? UIAlertController) != nil {
            return
        }
        
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: preferredStype)
        for action in actions {
            alertViewController.addAction(action)
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    func showWarningAlert(message: String?) {
        let closeAction = UIAlertAction(title: "Đóng", style: .default, handler: nil)
        showAlert(title: "Thông báo", message: message, preferredStype: .alert, actions: closeAction)
    }
}
