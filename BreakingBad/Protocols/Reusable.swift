//
//  Reusable.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import UIKit
//MARK: Reusing cells protocols

protocol Reusable: class {}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UIViewController {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

