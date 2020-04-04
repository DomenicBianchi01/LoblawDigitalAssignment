//
//  ArticlesTableViewController.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - ArticlesTableViewController

class ArticlesTableViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Manual configuration required since the app needs to support iOS 12
        if traitCollection.userInterfaceStyle == .dark {
            loadingIndicator.style = .white
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchArticles), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        loadingIndicator.startAnimating()
    
        fetchArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showArticleSegue,
            let selectedArticle = viewModel.selectedArticle,
            let viewController = segue.destination as? Configurable
        {
            viewController.configure(using: selectedArticle)
        }
    }
    
    // MARK: Private
    
    private let viewModel = ArticlesViewModel()
    
    @objc private func fetchArticles(_ sender: UIRefreshControl? = nil) {
        viewModel.fetchArticles { result in
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.tableView.isHidden = false
                sender?.endRefreshing()
                
                switch result {
                case .success:
                    self.tableView.reloadData()
                case .failure(let error):
                    self.displayAlert(title: "Error", message: error.message)
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ArticlesTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(in: tableView, at: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension ArticlesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedArticle(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.showArticleSegue, sender: self)
    }
}
