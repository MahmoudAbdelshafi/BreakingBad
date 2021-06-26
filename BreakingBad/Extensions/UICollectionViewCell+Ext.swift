//
//  UICollectionViewCell+Ext.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 25/06/2021.
//

import UIKit

//MARK: Reusing CollectionView cell extension

extension UICollectionViewCell: Reusable, NibLoadable {}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type)  {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(":: Unable to dequeue cell with identifier : \(T.reuseIdentifier)")
        }
        return cell
    }
}


