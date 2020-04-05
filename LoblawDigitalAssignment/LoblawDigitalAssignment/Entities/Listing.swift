//
//  Listing.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - Listing

struct Listing: Decodable {
    
    // MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case data
        case children
    }
    
    // MARK: Internal
    
    init(articles: [Article]) {
        self.articles = articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let articles = try data.decode([Article].self, forKey: .children)
        
        self.init(articles: articles)
    }
    
    let articles: [Article]

}
