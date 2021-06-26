//
//  Alert+UIVIewController.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil, message: String? = nil, actionTitle: String? = "Ok" ,okAction:(()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (_) in
            okAction?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
