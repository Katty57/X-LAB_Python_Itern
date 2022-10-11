//
//  CartModel.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

protocol CartModelProtocol {
    var basket: [ProductModelProtocol] {get}
    var delivery: String {get}
    var id: String {get}
    var total: String {get}
}

protocol ProductModelProtocol {
    var id: Int {get}
    var images: String {get}
    var price: String {get}
    var title: String {get}
}

class CartModel: CartModelProtocol {
    
    var basket: [ProductModelProtocol] {
        cart.basket.map {
            ProductModel(product: $0)
        }
    }
    
    var delivery: String {
        cart.delivery
    }
    
    var id: String {
        cart.id
    }
    
    var total: String {
        "$ \(cart.total) us"
    }
    
    private var cart: CartResponse
    
    init(cart: CartResponse) {
        self.cart = cart
    }
    
}

class ProductModel: ProductModelProtocol {
    
    var id: Int {
        product.id
    }
    
    var images: String {
        product.images
    }
    
    var price: String {
        "$\(product.price).00"
    }
    
    var title: String {
        product.title
    }
    
    private var product: CartResponse.ProductResponse
    
    init(product: CartResponse.ProductResponse) {
        self.product = product
    }
}
