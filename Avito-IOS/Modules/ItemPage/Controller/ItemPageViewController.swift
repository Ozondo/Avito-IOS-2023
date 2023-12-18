//
//  ItemPageViewController.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 17.12.2023.
//

import UIKit

class ItemPageViewController: UIViewController {
    
    //MARK: - private properties
    private let itemPageView = ItemPageView()
    private let service: ItemPageService
    private let id: String
    
    init(service: ItemPageService, id: String) {
        self.service = service
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netWork()
    }
    
    override func loadView() {
        view = itemPageView
    }
    
    private func netWork() {
        DispatchQueue.main.async {
            self.service.loadItems(id: self.id, completion:  { [weak self] result in
                switch result {
                case .success(let success):
                    guard
                        let imgURL = success.imageURL,
                        let title = success.title,
                        let price = success.price,
                        let location = success.location,
                        let address = success.address,
                        let createdDate = success.createdDate,
                        let description = success.description,
                        let phoneNumber = success.phoneNumber,
                        let email = success.email
                    else { return }
                    
                    self!.itemPageView.updateInfoItemPage(.init(id: self?.id ?? "", title: title, price: price, location: location, imageURL: imgURL, createdDate: createdDate, description: description, email: email, phoneNumber: phoneNumber, address: address))
                    
                case .failure(_):
                    print("error")
                }
                
            })
        }
    }
    
}
