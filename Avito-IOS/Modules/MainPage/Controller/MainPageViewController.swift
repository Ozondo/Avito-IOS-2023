//
//  ViewController.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 16.12.2023.
//

import UIKit

final class MainPageViewController: UIViewController {
    // MARK: - private properties
    private let service: MainPageService
    
    private let mainPageView = MainPageView()
    
    private var items: [ModelMainPage] = []
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        network()
        setupTitle()
        setUpView()
    }
    // MARK: - loadView
    override func loadView() {
        view = mainPageView
    }
    // MARK: - title
    private func setupTitle(){
        title = "Avito IOS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    // MARK: - init
    init(service: MainPageService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        mainPageView.onCellTapped = { [weak self] index in
            guard let self,index < self.items.count else {return}
            let item = self.items[index].id
            let viewController = ItemPageViewController(service: ItemPageServiceImpl(), id: item)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    // MARK: - Network
    private func network() {
        DispatchQueue.main.async {
            self.service.loadItems(completion: { [weak self] result in
                switch result {
                case .success(let success):
                    self?.items = success.advertisements
                    self?.mainPageView.setItems(self?.items ?? [])
                case .failure(let error):
                    print("error")
                }
            })
        }
    }
}

