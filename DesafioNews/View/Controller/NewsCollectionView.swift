//
//  NewsCollectionView.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return spotlightViewModel.countItems
        }else{
            return feedViewModel.countItems
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCell", for: indexPath) as! SpotlightCell
            cell.imageView.image = spotlightViewModel.returnImage(index: indexPath.row)
            cell.title.text = spotlightViewModel.returnTitle(index: indexPath.row)
            cell.subtitle.text = spotlightViewModel.returnDescription(index: indexPath.row)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
            cell.imageView.image = feedViewModel.returnImage(index: indexPath.row)
            cell.title.text = feedViewModel.returnTitle(index: indexPath.row)
            cell.subtitle.text = feedViewModel.returnDescription(index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlString = spotlightViewModel.returnUrl(index: indexPath.row) else {return}
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        newsView.activityIndicator.stopAnimating()
    }
    
    
}
