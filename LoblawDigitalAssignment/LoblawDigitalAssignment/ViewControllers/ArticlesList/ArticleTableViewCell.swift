//
//  ArticleTableViewCell.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - ArticleTableViewCell

class ArticleTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var articleImageView: UIImageView!
    @IBOutlet private var articleImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private var articleImageViewHeightConstraint: NSLayoutConstraint!

    // MARK: Internal
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 13, *) {
            loadingIndicator.style = .medium
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loadingIndicator.startAnimating()

    }
}

// MARK: - Configurable

extension ArticleTableViewCell: Configurable {
    
    // MARK: Internal
    
    func configure(using data: Any) {
        guard let article = data as? Article else {
            titleLabel.text = nil
            articleImageView.image = nil
            return
        }
        
        titleLabel.text = article.title
        articleImageView.image = article.image

        if article.thumbnailUrl == nil {
            loadingIndicator.stopAnimating()
            articleImageViewTopConstraint.constant = 0
            articleImageViewHeightConstraint.isActive = false
        } else {
            articleImageViewTopConstraint.constant = 10
            articleImageViewHeightConstraint.isActive = true
            
            if article.image != nil {
                articleImageViewHeightConstraint.isActive = false
                loadingIndicator.stopAnimating()
            }
        }
    }
}
