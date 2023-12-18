//
//  ItemPageService.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 17.12.2023.
//

import Foundation
import Moya

//MARK: - Service
protocol ItemPageService {
    func loadItems(id: String,completion: @escaping (Result<ItemPageResponse,Error>) -> ())
}
enum ItemPageTarget {
    case getInfoAboutItem(id: String)
}
extension ItemPageTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.avito.st/")!
    }
    
    var path: String {
        switch self {
        case .getInfoAboutItem(let id):
            return "s/interns-ios/details/\(id).json"
        }

    }
    var method: Moya.Method {
        switch self {
        case .getInfoAboutItem:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getInfoAboutItem:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
// MARK: - Impl

final class ItemPageServiceImpl: ItemPageService {
    
    private let provider = MoyaProvider<ItemPageTarget>()
    
    func loadItems(id: String,completion: @escaping (Result<ItemPageResponse, Error>) -> ()) {
        provider.request(.getInfoAboutItem(id: id), completion: { result in
            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let resultModel = try JSONDecoder().decode(ItemPageResponse.self, from: data)
                    completion(.success(resultModel))
                    
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

