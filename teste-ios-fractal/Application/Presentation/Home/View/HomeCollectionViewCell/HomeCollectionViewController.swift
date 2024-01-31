//
//  HomeCollectionViewController.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit
import TinyConstraints

class YourCollectionViewController: UICollectionViewController {

    let data = ["Item 1", "Item 2", "Item 3", "Item 4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell

        // Configure a célula com dados
        cell.configure(withTitle: data[indexPath.item])

        return cell
    }

    // Adicione os métodos necessários para o layout da coleção
    // Por exemplo, o tamanho de cada célula
}
