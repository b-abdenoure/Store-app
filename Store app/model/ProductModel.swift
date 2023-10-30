//
//  ProductModel.swift
//  Store
//
//  Created by Abdenoure Boudlal on 4/4/23.
//

import Foundation

struct ProductsModel: Codable {
    var id: Int!
    var title: String!
    var price: Double!
    var description: String!
    var image: String!
    var category: String!
}
