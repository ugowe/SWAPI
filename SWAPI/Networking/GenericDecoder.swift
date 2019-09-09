//
//  GenericDecoder.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

protocol GenericDecoder {
    
    var defaultSession: URLSession { get }
    func fetch<Element: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> Element?, completion: @escaping (Result<Element, APIError>) -> Void)
}

extension GenericDecoder {
    
    typealias JSONCompletionBlock = (Decodable?, APIError?) -> Void
    
    func fetch<Element: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> Element?, completion: @escaping (Result<Element, APIError>) -> Void) {
        
        let dataTask = decodingDataTask(with: request, decodingType: Element.self) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidDataError))
                    }
                    return
                }
                
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingError))
                }
            }
        }
        dataTask.resume()
    }
    
    func decodingDataTask<Element: Decodable>(with request: URLRequest, decodingType: Element.Type, completionHandler completion: @escaping JSONCompletionBlock) -> URLSessionDataTask {
        
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                completion(nil, .requestFailed(description: error.debugDescription))
                return
            }
            
            guard let responseData = data else {
                completion(nil, .invalidDataError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let genericModel = try decoder.decode(decodingType, from: responseData)
                completion(genericModel, nil)
            } catch let error {
                completion(nil, .jsonConversionFailure(description: error.localizedDescription))
            }
        }
        
        return dataTask
    }
    
}
