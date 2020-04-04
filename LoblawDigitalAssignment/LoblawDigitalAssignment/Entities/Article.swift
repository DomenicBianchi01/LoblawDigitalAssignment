//
//  Article.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - Article

class Article: Decodable {
    
    // MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case data
        case title
        case body = "selftext"
        case thumbnailUrl = "thumbnail"
    }
    
    // MARK: Internal
    
    init(title: String, body: String, thumbnailUrl: String?, image: UIImage? = nil) {
        self.title = title
        self.body = body
        self.thumbnailUrl = thumbnailUrl
        self.image = image
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let article = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        let title = try article.decode(String.self, forKey: .title)
        let body = try article.decode(String.self, forKey: .body)
        let thumbnailUrl = try article.decode(String.self, forKey: .thumbnailUrl)
        
        if thumbnailUrl == "self" || thumbnailUrl == "default" {
            self.init(title: title, body: body, thumbnailUrl: nil)
        } else {
            self.init(title: title, body: body, thumbnailUrl: thumbnailUrl)
        }
    }
    
    let title: String
    let body: String
    let thumbnailUrl: String?
    var image: UIImage?

}
