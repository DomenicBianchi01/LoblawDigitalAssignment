//
//  TextTableViewCell.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-03.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - TextTableViewCell

class TextTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet private var bodyLabel: UILabel!
    
}

// MARK: - Configurable

extension TextTableViewCell: Configurable {
    
    // MARK: Internal
    
    func configure(using data: Any) {
        guard let text = data as? String else {
            bodyLabel.text = nil
            return
        }
        
        bodyLabel.text = text
        
    }
}
