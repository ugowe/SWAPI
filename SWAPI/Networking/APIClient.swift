//
//  APIClient.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

struct APIClient {
    
    // MARK: - Properties
    
    static let shared = APIClient()
    private init() {}
    
    typealias JSONDictionary = [String: Any]
    var defaultSession = URLSession(configuration: .default)
    
    // MARK: Methods
    
    func decodeRootResources(completion: @escaping (Result<[RootResource], APIError>) -> Void) {
        self.fetchElement(urlString: Constants.API.baseUrlEndpoint) { (result) in
            switch result {
            case .success(let data):
                guard let resources = try? JSONDecoder().decode([String: String].self, from: data) else {
                    return completion(.failure(.jsonParsingError))
                }
                
                var rootResources: [RootResource] = []
                for resource in resources {
                    let rootResource = RootResource(name: resource.key, URL: resource.value, type: RootResource.RootResourceType(rawValue: resource.key) ?? RootResource.RootResourceType.people)
                    rootResources.append(rootResource)
                }
                
                rootResources = rootResources.sorted(by: { $0.resourceType < $1.resourceType })
                completion(.success(rootResources))
            case .failure(let error):
                completion(.failure(.requestFailed(description: error.customDescription)))
            }
        }
    }
    
    func decodeGenericCategory(urlString: String, completion: @escaping (Result<[GenericCategory], APIError>) -> Void) {
        self.fetchElement(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let categoryInfo = try? decoder.decode(CategoryInfo.self, from: data) else {
                    return completion(.failure(.jsonParsingError))
                }
                
                let categoryResults = categoryInfo.results
                
                completion(.success(categoryResults))
            case .failure(let error):
                completion(.failure(.requestFailed(description: error.customDescription)))
            }
        }
    }
    
    func decodeGenericItem(urlString: String, completion: @escaping (Result<[GenericItem], APIError>) -> Void) {
        self.fetchElement(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                guard let itemDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary else {
                    return completion(.failure(.jsonParsingError))
                }
                
                guard let elementItems = itemDictionary else {
                    return completion(.failure(.jsonParsingError))
                }
                
                var itemDetailsArray: [GenericItem] = []
                for elementItem in elementItems {
                    let itemDetail = GenericItem(itemKey: elementItem.key.convertFromSnakeCase, itemValue: elementItem.value)
                    itemDetailsArray.append(itemDetail)
                }
                
                completion(.success(itemDetailsArray))
            case .failure(let error):
                completion(.failure(.requestFailed(description: error.customDescription)))
            }
        }
    }
    
    private func fetchElement(urlString: String, completion: @escaping (Result<Data, APIError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        let dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(description: error.localizedDescription)))
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                completion(.failure(.responseUnsuccessful(description: error.debugDescription)))
                return
            }
            
            guard let data = data else {
                return completion(.failure(.invalidDataError))
            }
            
            completion(.success(data))
        }
        
        dataTask.resume()
    }
}
