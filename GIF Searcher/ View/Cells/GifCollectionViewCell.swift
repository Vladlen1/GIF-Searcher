//
//  GifCollectionViewCell.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import UIKit
import Kingfisher

class GifCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var gifImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with model: GifViewModel) {
        let placeholder = UIImage(named: "ic_loadData")
        
        self.gifImageView.kf.setImage(with: model.url, placeholder: placeholder, options: [.transition(.fade(0.2))])
    }

}
