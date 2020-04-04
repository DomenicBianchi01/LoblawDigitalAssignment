//
//  ArticleTableViewController.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-03.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//


import UIKit

// MARK: - ArticleTableViewController

class ArticleTableViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: Private
    
    private let viewModel = ArticleViewModel()
    
}

// MARK: - UITableViewDataSource

extension ArticleTableViewController: UITableViewDataSource {
    
    // MARK: - Internal
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(in: tableView, at: indexPath)
    }
}

// MARK: - Configurable

extension ArticleTableViewController: Configurable {
    
    // MARK: Internal
    
    func configure(using data: Any) {
        guard let article = data as? Article else {
            return
        }
        
        title = article.title
        viewModel.article = article
        
    }
}
