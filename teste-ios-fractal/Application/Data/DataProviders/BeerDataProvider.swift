//
//  BeerDataProvider.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 31/01/24.
//

import Foundation

protocol BeerDataProvider {
    func fetchBeers(completion: @escaping ([BeersModel]?, Error?) -> Void)
}

class APIBeerDataProvider: BeerDataProvider {
    
    func fetchBeers(completion: @escaping ([BeersModel]?, Error?) -> Void) {
        guard let url = APIConstants.apiURL else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data returned", code: 1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let beers = try decoder.decode([BeersModel].self, from: data)
                completion(beers, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
}
