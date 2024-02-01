//
//  HomeViewModel.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func setListener()
    
}

final class HomeViewModel: NSObject {
    private let coordinator: HomeCoordinating
    
    weak var viewController: HomeViewControllerDisplay?
    
    let beerDataProvider = APIBeerDataProvider()
    private var fetchBeersUseCase: FetchBeersUseCase!
    public var beers: [BeersModel] = []
    
    init(coordinator: HomeCoordinating = HomeCoordinator()) {
        self.coordinator = coordinator
    }
    
    @objc private func fetchData() {
        fetchBeersUseCase = BeerListUseCase(beerDataProvider: beerDataProvider)

        fetchBeersUseCase.execute { [weak self] (fetchedBeers, error) in
            guard let self = self else { return }
            
            if let error = error {
            
                print("Erro ao buscar cervejas: \(error.localizedDescription)")
                return
            }
            
            if let fetchedBeers = fetchedBeers {
                self.beers = fetchedBeers
                print(fetchedBeers)
                
                DispatchQueue.main.async{
                    self.viewController?.reloadData(with: fetchedBeers)
                    
                }
                
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    public func setListener() {
        fetchData()
    }
}
