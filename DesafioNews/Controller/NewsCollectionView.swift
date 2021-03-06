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
        switch section {
            case 0:
                return spotlightViewModel.countItems
            default:
                return feedViewModel.countItems
        }
    }
    
    // MARK: Configure Cells
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCell", for: indexPath) as! SpotlightCell
                cell.title.text = spotlightViewModel.returnTitle(index: indexPath.row)
                cell.subtitle.text = spotlightViewModel.returnDescription(index: indexPath.row)
                cell.date.text = spotlightViewModel.returnDate(index: indexPath.row)
                cell.favoriteImageView.isHidden = spotlightViewModel.returnFavoriteIsHidden(index: indexPath.row)
                if let urlImage = spotlightViewModel.returnImageUrl(index: indexPath.row){
                    cell.imageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "spotlight\(indexPath.row).png"))
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
                cell.title.text = feedViewModel.returnTitle(index: indexPath.row)
                cell.subtitle.text = feedViewModel.returnDescription(index: indexPath.row)
                cell.date.text = feedViewModel.returnDate(index: indexPath.row)
                cell.favoriteImageView.isHidden = feedViewModel.returnFavoriteIsHidden(index: indexPath.row)
                if let urlImage = feedViewModel.returnImageUrl(index: indexPath.row){
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
                guard let newsTitle = spotlightViewModel.returnTitle(index: indexPath.row) else {return}
                viewControllerPresenter?.present(self, to: WebViewController(urlString: urlString, newsTitle: newsTitle), newTree: false)
            default:
                guard let urlString = feedViewModel.returnUrl(index: indexPath.row) else {return}
                guard let newsTitle = feedViewModel.returnTitle(index: indexPath.row) else {return}
                viewControllerPresenter?.present(self, to: WebViewController(urlString: urlString, newsTitle: newsTitle), newTree: false)
        }
    }
    
    // MARK: Will Displey Cell
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        newsView.activityIndicator.stopAnimating()
        if indexPath.section == 1 && indexPath.row == feedViewModel.countItems - 10{
            feedViewModel.request(components: feedViewModel.returnUrlComponents())
        }
    }
    
}
