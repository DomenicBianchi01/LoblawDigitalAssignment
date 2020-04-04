//
//  StringExtensions.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import Foundation

// MARK: - String

extension String {
    
    // MARK: Internal
    
    var isValidUrl: Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let match = detector?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        return match?.range.length == utf16.count
    }
}
