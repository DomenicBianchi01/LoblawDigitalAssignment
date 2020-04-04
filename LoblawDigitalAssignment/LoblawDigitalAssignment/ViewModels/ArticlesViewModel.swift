//
//  ArticlesViewModel.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - ArticlesViewModel

class ArticlesViewModel {
    
    // MARK: Internal
    
    private(set) var selectedArticle: Article? = nil
    
    func fetchArticles(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        JSONService().request(from: "https://www.reddit.com/r/swift/.json", expecting: Articles.self) { result in
            switch result {
            case .success(let articles):
                self.articles = articles.articles
                
                let imageService = ImageService()
    
                DispatchQueue.global(qos: .background).async {
                    let dispatchGroup = DispatchGroup()
                    for article in self.articles {
                        guard let thumbnailUrl = article.thumbnailUrl else {
                            continue
                        }
                        
                        dispatchGroup.enter()
                        imageService.fetchImage(from: thumbnailUrl) { result in
                            switch result {
                            case .success(let image):
                                article.image = image
                                dispatchGroup.leave()
                            case .failure:
                                dispatchGroup.leave()
                            }
                        }
                    }
                    
                    dispatchGroup.wait()
                    completion(.success(()))
                }
                
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setSelectedArticle(index: Int) {
        selectedArticle = articles[index]
    }
    
    // MARK: Private
    
    private var articles: [Article] = []
    
}

// MARK: - TableViewModelable

extension ArticlesViewModel: TableViewModelable {
    
    // MARK: Internal
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return articles.count
    }
    
    func cellForRow(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.articleCellReuseIdentifier, for: indexPath)
        
        if let configurableCell = cell as? Configurable {
            configurableCell.configure(using: articles[indexPath.row])
        }
        
        return cell
    }
}
