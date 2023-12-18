//
//  MainPageView.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 16.12.2023.
//

import UIKit

final class MainPageView: UIView {
    
    var onCellTapped: ((Int) -> ())?
    
    // MARK: - private properties
    private enum Const {
        static let leadingConst: CGFloat = 10
        static let trailingConst: CGFloat = -10
        static let cornerRariusCell: CGFloat = 15
        static let heightCell: CGFloat = 250
        static let spacingBetweenCells: CGFloat = 15
        static let borderWidhtCell: CGFloat = 1
    }
    private let collectionItems: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    private var items: [ModelMainPage] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        collectionSetup()
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupView
    private func setupView() {
        backgroundColor = .white
    }
    // MARK: - collectionSetup
    private func collectionSetup() {
        collectionItems.dataSource = self
        collectionItems.delegate = self
        collectionItems.register(MainPageCell.self, forCellWithReuseIdentifier: "id")
        collectionItems.showsVerticalScrollIndicator = false
    }
    // MARK: - addSubview
    private func addSubviews() {
        [collectionItems].forEach({ item in
            addSubview(item)
        })
    }
    // MARK: - layout
    override func layoutSubviews() {
        [collectionItems].forEach({ item in
            item.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            collectionItems.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionItems.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionItems.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingConst),
            collectionItems.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Const.trailingConst)
        ])
    }
}
// MARK: - DataSource, UICollectionViewDelegateFlowLayout
extension MainPageView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionItems.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? MainPageCell else { return MainPageCell() }
        cell.clipsToBounds = true
        cell.layer.cornerRadius = Const.cornerRariusCell
        cell.layer.borderWidth = Const.borderWidhtCell
        
        let itemsForCell = items[indexPath.item]
        cell.updateInfo(itemsForCell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Const.spacingBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bounds.width/2)-Const.spacingBetweenCells, height: Const.heightCell)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionItems.deselectItem(at: indexPath, animated: true)
        onCellTapped?(indexPath.item)
    }
}

// MARK: - items
extension MainPageView {
    func setItems(_ itemsFromNetwork: [ModelMainPage]) {
        self.items = itemsFromNetwork
        collectionItems.reloadData()
    }
}
