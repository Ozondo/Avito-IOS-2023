//
//  MainPageCell.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 16.12.2023.
//

import UIKit
import Kingfisher

final class MainPageCell: UICollectionViewCell {
    // MARK: - private properties
    
    private enum Const {
        static let topConst: CGFloat = 5
        static let leadingConst: CGFloat = 10
        static let trailingConst: CGFloat = -5
        static let titleSize: CGFloat = 22
        static let priceSize: CGFloat = 18
        static let localAndDateSize: CGFloat = 12
        static let topConstAfterTitle: CGFloat = 10
    }
    
    private let imageMainPage = UIImageView()
    
    private let titleMainPage: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: Const.titleSize)
        title.text = "Iphone 12"
        return title
    }()
    private let priceMainPage: UILabel = {
        let price = UILabel()
        price.font = UIFont(name: "HelveticaNeue-Bold", size: Const.priceSize)
        price.text = "79.800 Р"
        return price
    }()
    private let locationMainPage: UILabel = {
        let location = UILabel()
        location.font = UIFont.systemFont(ofSize: Const.localAndDateSize)
        location.text = "Ростов-на-Дону"
        return location
    }()
    private let createdDateMainPage: UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: Const.localAndDateSize)
        date.text = "11.03.2231"
        return date
    }()
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        imageSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - imageSetup
    
    private func imageSetup() {
        imageMainPage.image = UIImage(named: "Image")
        imageMainPage.contentMode = .scaleToFill

    }
    // MARK: - addSubviews
    private func addSubviews() {
        [imageMainPage,titleMainPage,priceMainPage,locationMainPage,createdDateMainPage].forEach({ element in
            contentView.addSubview(element)
        })
    }
    // MARK: - layout
    override func layoutSubviews() {
        [imageMainPage,titleMainPage,priceMainPage,locationMainPage,createdDateMainPage].forEach({ element in
            element.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate( [
            imageMainPage.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageMainPage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageMainPage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageMainPage.widthAnchor.constraint(equalToConstant: bounds.width),
            imageMainPage.heightAnchor.constraint(equalToConstant: bounds.height/2),
            
            titleMainPage.topAnchor.constraint(equalTo: imageMainPage.bottomAnchor, constant: Const.topConst),
            titleMainPage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingConst),
            titleMainPage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingConst),
            
            priceMainPage.topAnchor.constraint(equalTo: titleMainPage.bottomAnchor, constant: Const.topConstAfterTitle),
            priceMainPage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingConst),
            priceMainPage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingConst),
            
            locationMainPage.topAnchor.constraint(equalTo: priceMainPage.bottomAnchor, constant: Const.topConstAfterTitle),
            locationMainPage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingConst),
            locationMainPage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingConst),
            
            createdDateMainPage.topAnchor.constraint(equalTo: locationMainPage.bottomAnchor, constant: Const.topConstAfterTitle),
            createdDateMainPage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingConst),
            createdDateMainPage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingConst)
        ])
    }
}
// MARK: - model
extension MainPageCell {
    func updateInfo(_ model: ModelMainPage) {
        titleMainPage.text = model.title
        priceMainPage.text = model.price
        locationMainPage.text = model.location
        createdDateMainPage.text = model.createdDate
        
        imageMainPage.kf.setImage(with: URL(string: model.imageURL))
    }
}
