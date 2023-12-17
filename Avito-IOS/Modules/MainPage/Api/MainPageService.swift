//
//  ApiRequest.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 16.12.2023.
//

import Foundation
import Moya

// MARK: - Service
protocol MainPageService {
    func loadItems(completion: @escaping (Result<Response, Error>) -> ())
}
// MARK: - Implementation
enum MainPageTarget {
    case getItems
}
extension MainPageTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.avito.st/")!
    }
    var path: String {
        return "/s/interns-ios/main-page.json"
    }
    var method: Moya.Method {
        switch self {
        case .getItems:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .getItems:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return nil
    }
}

final class MainPageServiceImpl: MainPageService {
    
    private let provider = MoyaProvider<MainPageTarget>()
    
    func loadItems(completion: @escaping (Result<Response, Error>) -> ()) {
        provider.request(.getItems, completion: { result in
            switch result {
            case.success(let result):
                let data = result.data
                do {
                    let resultModel = try JSONDecoder().decode(Response.self, from: data)
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
