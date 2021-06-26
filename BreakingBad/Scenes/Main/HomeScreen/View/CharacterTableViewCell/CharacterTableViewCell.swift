//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var characterImg: UIImageView!
    @IBOutlet private weak var characterNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func configure(charachter: Character) {
        characterImg.kf.setImage(with: URL(string: charachter.img?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))
        characterNameLbl.text = charachter.name?.uppercased()
    }
}
