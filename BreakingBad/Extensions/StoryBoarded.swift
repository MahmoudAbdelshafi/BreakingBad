//
//  StoryBoarded.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 26/06/2021.
//

import UIKit

protocol StoryBoarded {
    static func instantiate() -> Self
}

extension StoryBoarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

extension UIViewController: StoryBoarded {}
