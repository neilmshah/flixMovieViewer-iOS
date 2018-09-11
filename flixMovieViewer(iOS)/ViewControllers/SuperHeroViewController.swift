//
//  SuperHeroViewController.swift
//  flixMovieViewer(iOS)
//
//  Created by Neil Shah on 9/10/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit

class SuperHeroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SuperHeroViewController.didPullToRefresh(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0 )
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal =  layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        fetchMovies()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathString)!
            
            cell.posterImageView.af_setImage(withURL: posterURL)
            
        }
        return cell
    }
    
    func fetchMovies() {
        //Network Request
        let url = URL(string: "https://api.themoviedb.org/3/movie/363088/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                //self.activityIndicator.stopAnimating()
                //self.refreshControl.endRefreshing()
                let alertController = UIAlertController(title: "Cannot get Movies", message: "There seems to be an issue with the internet connection", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                }
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //Get the array of movies
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                //self.allMovies = movies
                
                self.collectionView.reloadData()
                
                //self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let movie = movies[(indexPath?.item)!]
        let superHeroDetailViewController = segue.destination as! SuperHeroDetailViewController
        superHeroDetailViewController.movie = movie
    }

}
