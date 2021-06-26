//
//  UIView.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 25/06/2021.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadiusValue: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            setNeedsLayout()
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
