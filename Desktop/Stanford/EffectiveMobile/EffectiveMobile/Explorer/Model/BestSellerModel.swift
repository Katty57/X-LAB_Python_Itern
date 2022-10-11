//
//  ExplorerModel.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

protocol BestSellerProtocol {
    var id: Int {get}
    var is_favorites: Bool {get}
    var title: String {get}
    var price_without_discount: String {get}
    var discount_price: String {get}
    var picture: String {get}
}

class BestSellerModel: BestSellerProtocol {
    var id: Int {
        bestSeller.id
    }
    
    var is_favorites: Bool {
        bestSeller.is_favorites
    }
    
    var title: String {
        bestSeller.title
    }
    
    var price_without_discount: String {
        "$\(bestSeller.price_without_discount)"
    }
    
    var discount_price: String {
        "$\(bestSeller.discount_price)"
    }
    
    var picture: String {
        bestSeller.picture
    }
    
    var bestSeller: ExplorerResponse.BestSeller
    
    init(bestSeller: ExplorerResponse.BestSeller) {
        self.bestSeller = bestSeller
    }
}
