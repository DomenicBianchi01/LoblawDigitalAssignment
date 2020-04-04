//
//  ImageService.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - ImageService

class ImageService {
    
    // MARK: Internal
    
    /**
     Similar to `JSONService` except this service will return a `UIImage`.
     
     - parameter url: The URL of the image
     - parameter completion: If successful, returns a `UIImage`, otherwise an `Error`
    */
    func fetchImage(from urlString: String, with completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        guard urlString.isValidUrl, let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.errorCode(response.statusCode)))
            } else if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.couldNotDecode))
            }
        }.resume()
    }
}
