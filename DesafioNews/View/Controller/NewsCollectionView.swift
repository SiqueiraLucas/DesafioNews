//
//  NewsCollectionView.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit
import SDWebImage

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: Number of Sections
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // MARK: Number of Cells
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return spotlightViewModel.countItems
        }else{
            return feedViewModel.countItems
        }
    }
    
    // MARK: Configure Cells
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCell", for: indexPath) as! SpotlightCell
            cell.delegate = self
            cell.title.text = spotlightViewModel.returnTitle(index: indexPath.row)
            cell.subtitle.text = spotlightViewModel.returnDescription(index: indexPath.row)
            cell.date.text = spotlightViewModel.returnDate(index: indexPath.row)
            cell.favoriteButton.setImage(UIImage(systemName: spotlightViewModel.returnFavoriteImageName(index: indexPath.row)), for: .normal)
            if let urlImage = spotlightViewModel.returnUrlImage(index: indexPath.row){
                cell.imageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "spotlight\(indexPath.row).png"))
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
            cell.title.text = feedViewModel.returnTitle(index: indexPath.row)
            cell.delegate = self
            cell.subtitle.text = feedViewModel.returnDescription(index: indexPath.row)
            cell.date.text = feedViewModel.returnDate(index: indexPath.row)
            cell.favoriteButton.setImage(UIImage(systemName: feedViewModel.returnFavoriteImageName(index: indexPath.row)), for: .normal)
            if let urlImage = feedViewModel.returnUrlImage(index: indexPath.row){
                cell.imageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "feed\(indexPath.row).png"))
            }
            return cell
        }
    }
    
    // MARK: Select Cell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                guard let urlString = spotlightViewModel.returnUrl(index: indexPath.row) else {return}
                openUrl(urlString: urlString)
            default:
                guard let urlString = feedViewModel.returnUrl(index: indexPath.row) else {return}
                openUrl(urlString: urlString)
        }
    }
    
    // MARK: Will Displey Cell
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        newsView.activityIndicator.stopAnimating()
        if indexPath.section == 1{
            if indexPath.row == feedViewModel.countItems - 10{
//                let endpoint = "https://mesa-news-api.herokuapp.com/v1/client/news?current_page=&per_page=&published_at="
//                let components = feedViewModel.returnUrlComponents()
//                feedViewModel.request(endpoint: endpoint, components: components)
            }
        }
    }
    
    // MARK: Open Url
    
    func openUrl(urlString: String){
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    
}

extension NewsViewController: CellDelegate{
    
    func didTapFavorite(_ cell: UICollectionViewCell) {
        guard let indexPath = self.newsView.collectionView.indexPath(for: cell) else {return}
        if indexPath.section == 0{
            spotlightViewModel.favorite(index: indexPath.row)
        }else{
            feedViewModel.favorite(index: indexPath.row)
        }
    }
    
    func didTapShare(_ cell: UICollectionViewCell) {
        
    }
}
