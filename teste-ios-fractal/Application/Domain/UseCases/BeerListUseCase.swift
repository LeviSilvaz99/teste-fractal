//
//  BeerListUseCase.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 31/01/24.
//

import Foundation

protocol FetchBeersUseCase {
    func execute(completion: @escaping ([BeersModel]?, Error?) -> Void)
}

class BeerListUseCase: FetchBeersUseCase {
    private let beerDataProvider: BeerDataProvider

    init(beerDataProvider: BeerDataProvider) {
        self.beerDataProvider = beerDataProvider
    }

    func execute(completion: @escaping ([BeersModel]?, Error?) -> Void) {
        beerDataProvider.fetchBeers(completion: completion)
    }
}


