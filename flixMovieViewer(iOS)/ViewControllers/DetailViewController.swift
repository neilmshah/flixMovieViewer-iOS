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
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabelView.text = movie["title"] as? String
            releaseDateLabelView.text = movie["release_date"] as? String
            overViewLabelView.text = movie["overview"] as? String
            
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterPathString = movie["poster_path"] as? String
            let backDropPathString = movie["backdrop_path"] as? String
           
            let backDropURL = URL(string: baseURLString + backDropPathString!)!
            backDropImageView.af_setImage(withURL: backDropURL)
            
            let posterURL = URL(string: baseURLString + posterPathString!)!
            let placeholderImage = UIImage(named: "placeholder")!
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: posterImageView.frame.size,
                radius: 20.0
            )
            posterImageView.af_setImage(withURL: posterURL, placeholderImage: placeholderImage, filter: filter, imageTransition: .crossDissolve(0.2))
            
        }

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
