//
//  ArticleTests.swift
//  LoblawDigitalAssignmentTests
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import XCTest
@testable import LoblawDigitalAssignment

// MARK: - ArticleTests

class ArticleTests: XCTestCase {
    
    // MARK: Internal
    
    func testArticleCount() {
        XCTAssertEqual(articlesData?.articles.count, 2)
    }
    
    func testArticleContents() {
        XCTAssertEqual(articlesData?.articles[0].title, "this is a random title")
        XCTAssertEqual(articlesData?.articles[0].body, "this is a random body")
        XCTAssertEqual(articlesData?.articles[0].thumbnailUrl, "https://b.thumbs.redditmedia.com/ZCc1LypighNbOlbsRULVMsZNB9ynV1223v8HAPdkOvU.jpg")
        
        XCTAssertEqual(articlesData?.articles[1].title, "this is another random title")
        XCTAssertEqual(articlesData?.articles[1].body, "this is another random body")
        XCTAssertNil(articlesData?.articles[1].thumbnailUrl)
    }
    
    // MARK: Private
    
    private lazy var articlesData = {
        try? JSONDecoder().decode(Articles.self, from: articlesJson.data(using: .utf8) ?? Data())
    }()
    
    private let articlesJson =
    """
        {
            "data": {
                "children": [
                    {
                        "data": {
                            "selftext": "this is a random body",
                            "title": "this is a random title",
                            "thumbnail": "https://b.thumbs.redditmedia.com/ZCc1LypighNbOlbsRULVMsZNB9ynV1223v8HAPdkOvU.jpg",
                        }
                    },
                    {
                        "data": {
                            "selftext": "this is another random body",
                            "title": "this is another random title",
                            "thumbnail": "self",
                        }
                    }
                ]
            }
        }
        """
}
