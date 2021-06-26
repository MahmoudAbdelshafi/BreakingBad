//
//  HomeHeaderCollectionViewCell.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import UIKit

class HomeHeaderCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var characterImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(image: String) {
        characterImg.image = UIImage(named: image)
    }
}
