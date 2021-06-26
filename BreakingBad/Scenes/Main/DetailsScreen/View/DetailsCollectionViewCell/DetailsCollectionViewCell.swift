//
//  DetailsCollectionViewCell.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 25/06/2021.
//

import UIKit
import Kingfisher

class DetailsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var bottomFadedShadowLayerView: UIView!
    @IBOutlet private weak var characterImg: UIImageView!
    @IBOutlet private weak var characterNameLbl: UILabel!
    @IBOutlet private weak var nickNameLbl: UILabel!
    @IBOutlet private weak var birthdayLbl: UILabel!
    @IBOutlet private weak var occupationLbl: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBottomFadedShadowLayerView()
    }
    
    func configure(charachter: Character, totalPagesNumber: Int, currentPage: Int) {
        characterImg.kf.setImage(with: URL(string: charachter.img?
                                            .addingPercentEncoding(
                                                withAllowedCharacters: .urlQueryAllowed) ?? ""))
        characterNameLbl.text = charachter.name
        nickNameLbl.text = charachter.nickname?.uppercased()
        birthdayLbl.text = charachter.birthday
        occupationLbl.text = charachter.occupation.map{$0.joined(separator: ", ")}
        pageControl.numberOfPages = totalPagesNumber
        pageControl.currentPage = currentPage
    }
}

//MARK:- Private Functions

extension DetailsCollectionViewCell {
    
    private func setupBottomFadedShadowLayerView() {
        bottomFadedShadowLayerView.backgroundColor = UIColor(hexString: "#111E1A")
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = bottomFadedShadowLayerView.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0.1, 1]
        bottomFadedShadowLayerView.layer.mask = gradientMaskLayer
    }
    
}
