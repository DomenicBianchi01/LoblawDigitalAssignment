//
//  TableViewModelable.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - TableViewModelable

protocol TableViewModelable {
    
    // MARK: Internal
    
    func numberOfRows(in section: Int) -> Int
    func cellForRow(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
    var numberOfSections: Int { get }
}
