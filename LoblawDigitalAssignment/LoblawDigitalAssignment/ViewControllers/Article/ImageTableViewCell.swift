//
//  ImageTableViewCell.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-03.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - ImageTableViewCell

class ImageTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet private var centeredImageView: UIImageView!
    
}

// MARK: - Configurable

extension ImageTableViewCell: Configurable {
    
    // MARK: Internal
    
    func configure(using data: Any) {
        guard let image = data as? UIImage else {
            centeredImageView.image = nil
            return
        }
        
        centeredImageView.image = image
        
    }
}
