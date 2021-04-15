//
//  FeedViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import Foundation

class FeedViewModel: NewsViewModel {
    
    //MARK: - Instances
    
    private var newCurrentPage = 0
    
    //MARK: Functions
    
    private func returnCurrentPage() ->String {
        newCurrentPage += 1
        return newCurrentPage.description
    }
    
    func returnUrlComponents() -> [URLQueryItem]{
        return [
            URLQueryItem(name: "current_page", value: returnCurrentPage()),
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "published_at", value: ""),
        ]
    }
}
