//
//  HomeStoreModel.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

protocol HomeStoreProtocol {
    var id: Int {get}
    var is_new: Bool? {get}
    var title: String {get}
    var subtitle: String? {get}
    var picture: String {get}
    var is_buy: Bool {get}
}

class HomeStoreModel: HomeStoreProtocol {
    
    var id: Int {
        homeStore.id
    }
    
    var is_new: Bool? {
        homeStore.is_new
    }
    
    var title: String {
        homeStore.title
    }
    
    var subtitle: String? {
        homeStore.subtitle
    }
    
    var picture: String {
        homeStore.picture
    }
    
    var is_buy: Bool {
        homeStore.is_buy
    }
    
    var homeStore: ExplorerResponse.HomeStore
    
    init(homeStore: ExplorerResponse.HomeStore) {
        self.homeStore = homeStore
    }
}
