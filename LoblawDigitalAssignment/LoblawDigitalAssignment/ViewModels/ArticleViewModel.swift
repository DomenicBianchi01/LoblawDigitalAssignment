//
//  ArticleViewModel.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - ArticleViewModel

class ArticleViewModel {
    
    // MARK: Internal
    
    var article: Article? = nil

}

// MARK: - TableViewModelable

extension ArticleViewModel: TableViewModelable {
    
    // MARK: Internal
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return article?.image == nil ? 1 : 2
    }
    
    func cellForRow(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier: String
        
        if indexPath.row == 0 && article?.image != nil {
            reuseIdentifier = Constants.imageReuseIdentifier
        } else {
            reuseIdentifier = Constants.textReuseIdentifier
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        guard let configurableCell = cell as? Configurable, let article = article else {
            return cell
        }
        
        if reuseIdentifier == Constants.imageReuseIdentifier {
            configurableCell.configure(using: article.image as Any)
        } else {
            configurableCell.configure(using: article.body)
        }
        
        return cell
    }
}
