//
//  NewsCollectionView.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotlightViewModel.countItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCell", for: indexPath) as! SpotlightCell
        cell.imageView.image = spotlightViewModel.returnImage(index: indexPath.row)
        cell.title.text = spotlightViewModel.returnTitle(index: indexPath.row)
        cell.subtitle.text = spotlightViewModel.returnDescription(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlString = spotlightViewModel.returnUrl(index: indexPath.row) else {return}
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    
}
