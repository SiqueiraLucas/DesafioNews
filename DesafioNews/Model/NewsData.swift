//
//  NewsData.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 13/04/21.
//

import Foundation

struct NewsData: Codable {
    var title: String
    var description: String
    var content: String
    var author: String
    var published_at: String
    var highlight: Bool
    var url: String
    var image_url: String
}
