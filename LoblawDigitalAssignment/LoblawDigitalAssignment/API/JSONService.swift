//
//  JSONService.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - JSONService

/// Use this class to perform HTTP requests.
class JSONService {
    
    // MARK: RequestType
    
    /// Used to specify the type of request that should be made
    enum RequestType: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    // MARK: Internal
    
    /**
     Fetch JSON data and parse it according to the `type` parameter in the function. In other words, the `url` must return JSON that maps to `type`.
     
     - parameter urlString: A string representation of the URL that will return JSON data. This function will check if the string does indeed represent a valid URL. If not, `NetworkError.invalidUrl` is returned.
     - parameter requestType: Specifies the type of request using the `RequestType` enum. Defaults to `GET`
     - parameter body: If this parameter is included, the dictionary is included in the body of the request. Defaults to `nil`
     - parameter type: The type of object that the fetched JSON data should be decoded to. NOTE: The type must conform to `Decodable`.
     - parameter completion: If the function successfully fetched and decoded the JSON data, the completion block will include the decoded data as an object that matches the type passed in the `type` parameter of this function. If the data could not be decoded, the completion block will contain a `NetworkError` instead.
     */
    func request<D: Decodable>(
        from urlString: String,
        requestType: RequestType = .get,
        body: [String : Any]? = nil,
        expecting type: D.Type,
        completion: @escaping (Result<D, NetworkError>) -> Void)
    {
        guard urlString.isValidUrl, let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                completion(.failure(.invalidBody))
                return
            }
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.errorCode(response.statusCode)))
            } else {
                do {
                    let json = try JSONDecoder().decode(type, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(.couldNotDecode))
                }
            }
        }.resume()
    }
}
