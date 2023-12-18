//
//  ItemPageView.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 17.12.2023.
//

import UIKit
import Kingfisher

class ItemPageView: UIView {
    //MARK: - private properties
    private var id: String = ""
    
    
    private let imageItemPage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    private let titleItemPage: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.font = UIFont.systemFont(ofSize: 30)
        return title
    }()
    private let priceItemPage: UILabel = {
        let price = UILabel()
        price.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        return price
    }()
    private let locationItemPage: UILabel = {
        let location = UILabel()
        return location
    }()
    private let createdDateItemPage: UILabel = {
        let date = UILabel()
        return date
    }()
    private let descriptionItemPage: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        description.layer.borderWidth = 1
        description.textAlignment = .left
        description.layer.cornerRadius = 10
        return description
    }()
    private let emailItemPage: UILabel = {
        let email = UILabel()
        return email
    }()
    private let phoneNumberItemPage: UILabel = {
        let phone = UILabel()
        return phone
    }()
    private let adressItemPage: UILabel = {
        let adress = UILabel()
        return adress
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        transMaskOff()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - addSubviews
    private func addSubviews() {
        [imageItemPage,titleItemPage,priceItemPage,locationItemPage,createdDateItemPage,descriptionItemPage,emailItemPage,phoneNumberItemPage,adressItemPage].forEach({ element in
            addSubview(element)
        })
    }
    
    //MARK: - transMaskOff
    private func transMaskOff() {
        [imageItemPage,titleItemPage,priceItemPage,locationItemPage,createdDateItemPage,descriptionItemPage,emailItemPage,phoneNumberItemPage,adressItemPage].forEach({ element in
            element.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    //MARK: - layout
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            imageItemPage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageItemPage.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageItemPage.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageItemPage.widthAnchor.constraint(equalToConstant: frame.width),
            imageItemPage.heightAnchor.constraint(equalToConstant: frame.height/3),
            
            titleItemPage.topAnchor.constraint(equalTo: imageItemPage.bottomAnchor),
            titleItemPage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleItemPage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceItemPage.topAnchor.constraint(equalTo: titleItemPage.bottomAnchor, constant: 10),
            priceItemPage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            priceItemPage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            locationItemPage.topAnchor.constraint(equalTo: priceItemPage.bottomAnchor,constant: 10),
            locationItemPage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            adressItemPage.topAnchor.constraint(equalTo: locationItemPage.bottomAnchor, constant: 10),
            adressItemPage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            createdDateItemPage.topAnchor.constraint(equalTo: priceItemPage.bottomAnchor, constant: 10),
            createdDateItemPage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            emailItemPage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            emailItemPage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            phoneNumberItemPage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            phoneNumberItemPage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            descriptionItemPage.topAnchor.constraint(equalTo: adressItemPage.bottomAnchor, constant: 15),
            descriptionItemPage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionItemPage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            descriptionItemPage.bottomAnchor.constraint(equalTo: phoneNumberItemPage.topAnchor)

            
            
        ])
    }
    //MARK: - setupView
    private func setupView(){
        backgroundColor = .white
    }
}
extension ItemPageView {
    func updateInfoItemPage(_ model: ModelItemPage) {
        id = model.id
        imageItemPage.kf.setImage(with: URL(string: model.imageURL))
        titleItemPage.text = model.title
        priceItemPage.text = model.price
        locationItemPage.text = model.location
        adressItemPage.text = model.address
        createdDateItemPage.text = model.createdDate
        descriptionItemPage.text = model.description
        emailItemPage.text = model.email
        phoneNumberItemPage.text = model.phoneNumber
        
        print(id)
        layoutIfNeeded()
    }
}
