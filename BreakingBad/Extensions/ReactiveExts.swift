//
//  ReactiveExts.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 25/06/2021.
//


import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `Loader.show()`, `Loader.hide()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                Loader.show()
            } else {
                Loader.hide()
            }
        })
    }
}
