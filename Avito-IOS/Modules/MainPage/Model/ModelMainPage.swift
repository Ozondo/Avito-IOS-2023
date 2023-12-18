//
//  ModelMainPage.swift
//  Avito-IOS
//
//  Created by Егор Иванов on 16.12.2023.
//

import Foundation
import UIKit


// MARK: - Model
struct ModelMainPage: Decodable{
    var id: String 
    var title: String
    var price: String
    var location: String
    var createdDate: String
    var imageURL: String
    
    enum CodingKeys: String,CodingKey {
        case id
        case title
        case price
        case location
        case createdDate = "created_date"
        case imageURL = "image_url"
    }
}
