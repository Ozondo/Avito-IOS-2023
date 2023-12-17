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
    // MARK: - Network
    private func network() {
        DispatchQueue.main.async {
            self.service.loadItems(completion: { [weak self] result in
                switch result {
                case .success(let success):
                    self?.items = success.advertisements
                    self?.mainPageView.setItens(self?.items ?? [])
                case .failure(let error):
                    print("error")
                }
            })
        }
    }
}

