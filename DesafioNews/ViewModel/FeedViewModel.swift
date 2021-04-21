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
    
    func returnUrlComponents() -> [String: Any]{
        return [
            "current_page" : returnCurrentPage(),
            "per_page" : "10",
            "published_at" : ""
        ]
    }
}
