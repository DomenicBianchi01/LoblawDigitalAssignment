//
//  NetworkError.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-03.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case invalidUrl
    case invalidBody
    case noData
    case couldNotDecode
    case errorCode(Int)
    
    // MARK: Internal
    
    /// A simple human readable string of the network error
    var message: String {
        switch self {
        case .invalidUrl:
            return "The URL provided is invalid"
        case .invalidBody:
            return "The contents of the body is not valid JSON"
        case .noData:
            return "No data was returned"
        case .couldNotDecode:
            return "Could not decode the data returned"
        case .errorCode(let code):
            return "The request returned status code: \(code)"
        }
    }
}
