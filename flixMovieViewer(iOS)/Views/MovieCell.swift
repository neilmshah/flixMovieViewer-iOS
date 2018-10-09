//
//  MovieCell.swift
//  flixMovieViewer(iOS)
//
//  Created by Neil Shah on 9/7/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie : Movie! {
        didSet {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            let posterURL = movie.posterURL
            let placeholderImage = UIImage(named: "placeholder")!
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: posterImageView.frame.size, radius: 5.0)
            posterImageView.af_setImage(withURL: posterURL!, placeholderImage: placeholderImage, filter: filter, imageTransition: .crossDissolve(0.2))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
