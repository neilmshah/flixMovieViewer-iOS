//
//  SuperHeroViewController.swift
//  flixMovieViewer(iOS)
//
//  Created by Neil Shah on 9/10/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import MBProgressHUD

class SuperHeroViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [Movie] = []
    var allMovies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        searchBar.delegate = self
        
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        cell.movies = movies[indexPath.item]
        return cell
    }
    
    func fetchMovies() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        MovieApiManager().superHeroMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.allMovies = self.movies
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
                MBProgressHUD.hide(for: self.view, animated: true)
            } else {
                print(error!.localizedDescription)
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let detailViewControler = segue.destination as! DetailViewController
        detailViewControler.movie = movies[(indexPath?.item)!]
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movies = searchText.isEmpty ? allMovies : allMovies.filter { (item: Movie) -> Bool in
            let i = item.title
            return i.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        movies = self.allMovies
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }

}
