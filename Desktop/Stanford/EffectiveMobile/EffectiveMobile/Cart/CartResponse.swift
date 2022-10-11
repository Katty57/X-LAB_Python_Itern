//
//  CartResponse.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

struct CartResponse: Codable {
    let basket: [ProductResponse]
    let delivery: String
    let id: String
    let total: Int
    
    struct ProductResponse: Codable {
        let id: Int
        let images: String
        let price: Int
        let title: String
    }
}

/*{
 "basket": [
   {
     "id": 1,
     "images": "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
     "price": 1500,
     "title": "Galaxy Note 20 Ultra"
   },
   {
     "id": 2,
     "images": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-silver-select?wid=470&hei=556&fmt=jpeg&qlt=95&.v=1631652954000",
     "price": 1800,
     "title": "iPhone 13"
   }
 ],
 "delivery": "Free",
 "id": "4",
 "total": 3300
}*/
