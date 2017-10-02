//
//  GifCollectionViewCell.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    func fill(gif: Gif) {
        gifImageView.loadGif(url: gif.url)
    }
}
