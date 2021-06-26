//
//  UITableView+Ext.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import UIKit

//MARK: Reusing tableview cell extension

extension UITableViewCell: Reusable, NibLoadable {}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(":: Unable to dequeue cell with identifier : \(T.reuseIdentifier)")
        }
        return cell
    }
}

