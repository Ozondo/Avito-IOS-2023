//
//  ApiResponse.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 16.12.2023.
//

import Foundation

struct Response: Decodable {
    let advertisements: [ModelMainPage]
}
