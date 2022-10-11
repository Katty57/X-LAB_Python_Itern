//
//  DetailsModel.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

protocol DetailsModelProtocol {
    var CPU: String {get}
    var camera: String {get}
    var capacity: [String] {get}
    var color: [String] {get}
    var id: String {get}
    var images: [String] {get}
    var isFavorites: Bool {get}
    var price: Int {get}
    var rating: Double {get}
    var sd: String {get}
    var ssd: String {get}
    var title: String {get}
}

class DetailsModel: DetailsModelProtocol {
    
    var CPU: String {
        details.CPU
    }
    
    var camera: String {
        details.camera
    }
    
    var capacity: [String] {
        details.capacity
    }
    
    var color: [String] {
        details.color
    }
    
    var id: String {
        details.id
    }
    
    var images: [String] {
        details.images
    }
    
    var isFavorites: Bool {
        details.isFavorites
    }
    
    var price: Int {
        details.price
    }
    
    var rating: Double {
        details.rating
    }
    
    var sd: String {
        details.sd
    }
    
    var ssd: String {
        details.ssd
    }
    
    var title: String {
        details.title
    }
    
    private var details: DetailsResponse
    
    init (details: DetailsResponse) {
        self.details = details
    }
}
