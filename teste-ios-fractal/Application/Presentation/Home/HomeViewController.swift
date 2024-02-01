//
//  ViewController.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit
import TinyConstraints

public protocol HomeViewControllerDisplay: AnyObject {
    
}

class HomeViewController: ViewController<HomeViewModelProtocol, UIView>, UISearchControllerDelegate {
    
    ///views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.backgroundColor = .none
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Beers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        if let glassIconView = searchController.searchBar.searchTextField.leftView as? UIImageView {
            glassIconView.tintColor = .white
        }
        
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.setIconColor(UIColor.green)
        
        return searchController
    }()
    
    private lazy var noResultImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "notFound")
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    private lazy var textNoResult: UILabel = {
        let l = UILabel()
        l.text = "Nem uma cervejaria encontrada !"
        l.font = UIFont(name: "Montserrat-Bold", size: 18)
        l.numberOfLines = 0
        l.textColor = Colors.graySmall.uiColor
        return l
    }()

    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal) // Usando o coração preenchido
        button.tintColor = .white
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var beers: [BeersModel] = []
    var search = [BeersModel]()
    var searching = false
    private var showOnlySavedCells = false
    private var savedCellIndices: Set<Int> = []
    private var fetchBeersUseCase: FetchBeersUseCase!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let beerDataProvider = APIBeerDataProvider()
        fetchBeersUseCase = BeerListUseCase(beerDataProvider: beerDataProvider)
        
        noResultImage.isHidden = true
        textNoResult.isHidden = true
        
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        navigationItem.searchController = nil
        
        setupNavigationBar()
        setupStatusBar()
        setupColorButtonCancel()
        
        // Chamar o caso de uso para buscar cervejas
        fetchBeersUseCase.execute { [weak self] (fetchedBeers, error) in
            guard let self = self else { return }
            
            if let error = error {
                // Lide com o erro, se houver
                print("Erro ao buscar cervejas: \(error.localizedDescription)")
                return
            }
            
            if let fetchedBeers = fetchedBeers {
                self.beers = fetchedBeers
                print(fetchedBeers)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func buildViewHierarchy() {
        view.addSubview(self.collectionView)
        view.addSubview(self.noResultImage)
        view.addSubview(self.textNoResult)
    }
    
    override func setupConstraints() {
        collectionView.topToSuperview(offset: 16)
        collectionView.leadingToSuperview()
        collectionView.trailingToSuperview()
        collectionView.bottomToSuperview()
        
        noResultImage.centerYToSuperview()
        noResultImage.centerXToSuperview()
        
        textNoResult.topToBottom(of: noResultImage, offset: 20)
        textNoResult.centerX(to: noResultImage)
    }
    
    private func setupColorButtonCancel() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
    }
    
    private func setupNavigationBar() {
        
        setNavigationBar()
        setButtonSearch()
        updateLayoutNavigationBar()
        navigationItem.title = "Beer List"
        
    }
    
    private func setNavigationBar() {
        if let navController = self.navigationController {
            navController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 20) as Any,
                NSAttributedString.Key.foregroundColor: UIColor(named: "colorWhite") ?? .white
            ]
        }
    }
    
    private func setButtonSearch() {
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        let searchBarItem = UIBarButtonItem(customView: searchButton)
        let heartBarItem = UIBarButtonItem(customView: heartButton)
            
        navigationItem.rightBarButtonItems = [searchBarItem, heartBarItem]
        
    }
    
    @objc private func heartButtonTapped() {
        heartButton.tintColor = heartButton.tintColor == .white ? .red : .white
        
        if savedCellIndices.isEmpty {
            
            savedCellIndices = Set(beers.enumerated().compactMap { index, beer in
                return UserDefaults.standard.bool(forKey: "Heart\(beer.id ?? 0)") ? index : nil
            })
        }

        if showOnlySavedCells {
            showOnlySavedCells = false
            noResultImage.isHidden = true
            textNoResult.isHidden = true
            savedCellIndices.removeAll()
        } else {
            
            if savedCellIndices.count == 0 {
                noResultImage.isHidden = false
                textNoResult.isHidden = false
            }
            showOnlySavedCells = true
        }

        collectionView.reloadData()
    }

    
    @objc private func searchButtonTapped() {
        
        if navigationItem.searchController == nil {
            UIView.animate(withDuration: 0.9) {
                self.navigationItem.searchController = self.searchController
                self.navigationItem.hidesSearchBarWhenScrolling = false
            }
        } else {
            UIView.animate(withDuration: 0.9) {
                self.navigationItem.searchController = nil
                self.navigationItem.hidesSearchBarWhenScrolling = true
            }
        }
        
    }
    
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
    
    private func updateLayoutNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(named: "colorBlue")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    func setupStatusBar(withStyle style: UIStatusBarStyle = .default) {
        AppDelegate.sharedAppDelegate.setupStatusBar(withStyle: style)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showOnlySavedCells {
            return savedCellIndices.count
        } else if searching {
            return search.count
        } else {
            return beers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell

        var beer: BeersModel

        if showOnlySavedCells {
            if let index = savedCellIndices.index(savedCellIndices.startIndex, offsetBy: indexPath.item, limitedBy: savedCellIndices.endIndex) {
                let savedIndex = savedCellIndices[index]
                beer = beers[savedIndex]
            } else {
                return UICollectionViewCell()
            }
        } else if searching {
            beer = search[indexPath.item]
            
        } else {
            beer = beers[indexPath.item]
        }

        cell?.configure(beer)

        return cell ?? UICollectionViewCell()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = beers[indexPath.item]
        let beerDetailVC = HomeDetailViewController()
        beerDetailVC.beers = selectedItem
        
        navigationController?.pushViewController(beerDetailVC, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search = beers.filter { $0.name?.lowercased().hasPrefix(searchText.lowercased()) ?? false }
        searching = true
        
        if search.isEmpty {
            noResultImage.isHidden = false
            textNoResult.isHidden = false
        } else {
            noResultImage.isHidden = true
            textNoResult.isHidden = true
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        collectionView.reloadData()
        
    }
}


extension HomeViewController: HomeViewControllerDisplay {
    
}

extension UISearchBar {
    func setIconColor(_ color: UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                let view = subSubView as? UITextInputTraits
                if view != nil {
                    let textField = view as? UITextField
                    let glassIconView = textField?.leftView as? UIImageView
                    glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
                    glassIconView?.tintColor = color
                    break
                }
            }
        }
    }
}
