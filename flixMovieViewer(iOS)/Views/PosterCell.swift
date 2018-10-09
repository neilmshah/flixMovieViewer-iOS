//
//  PosterCell.swift
//  flixMovieViewer(iOS)
//
//  Created by Neil Shah on 9/10/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import AlamofireImage

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movies : Movie! {
        didSet {
            let posterURL = movies.posterURL
            let placeholderImage = UIImage(named: "placeholder")!
            posterImageView.af_setImage(withURL: posterURL!, placeholderImage: placeholderImage)
        }
    }
}
