//
//  DetailViewController.swift
//  flixMovieViewer(iOS)
//
//  Created by Neil Shah on 9/10/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var releaseDateLabelView: UILabel!
    @IBOutlet weak var overViewLabelView: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabelView.text = movie.title
        releaseDateLabelView.text = movie.releaseDate
        overViewLabelView.text = movie.overview
        let backDropURL = movie.backDropURL
        backDropImageView.af_setImage(withURL: backDropURL!)
        
        let posterURL = movie.posterURL
        let placeholderImage = UIImage(named: "placeholder")!
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                            size: posterImageView.frame.size,
                            radius: 20.0
                        )
        posterImageView.af_setImage(withURL: posterURL!, placeholderImage: placeholderImage, filter: filter, imageTransition: .crossDissolve(0.2))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
