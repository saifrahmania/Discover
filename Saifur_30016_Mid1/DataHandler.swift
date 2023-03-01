//
//  APIdataHandeler.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 14/1/23.
//

import Foundation

// MARK: - Welcome
struct DataHandler: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    var title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
