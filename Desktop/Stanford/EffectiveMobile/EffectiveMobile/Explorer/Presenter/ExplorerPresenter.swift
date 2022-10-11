//
//  ExplorerPresenter.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

protocol ExplorerViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol ExplorerPresenterProtocol {
    var view: ExplorerViewProtocol? {get set}
    var url: String {get}
    var homeStoreCount: Int {get}
    var bestSellerCount: Int {get}
    func loadView()
    func homeStoreModel (for indexPah: IndexPath) -> HomeStoreProtocol
    func bestSellerModel (for indexPah: IndexPath) -> BestSellerProtocol
}

class ExplorerPresenter: ExplorerPresenterProtocol {
    var homeStoreCount: Int {
        homeStore.count
    }
    
    var bestSellerCount: Int {
        bestSellers.count
    }
    
    var url: String
    var view: ExplorerViewProtocol?
    var bestSellers: [BestSellerProtocol] = []
    var homeStore: [HomeStoreProtocol] = []
    
    init(url: String) {
        self.url = url
    }
    
    func loadView() {
        getData { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.updateView(withLoader: false)
                
                switch result{
                case .success(let explorerResponse):
                    if let bestSeller = self?.bestSellerModel(for: explorerResponse.best_seller),
                    let homeStore = self?.homeStoreModel(for: explorerResponse.home_store) {
                        self?.bestSellers = bestSeller
                        self?.homeStore = homeStore
                        self?.view?.updateView()
                    }
                case .failure(let error):
                    self?.view?.updateView(withError: error.localizedDescription)
                }
            }
        }
//        view?.updateView()
    }
    
    private func getData (completion: @escaping (Result<ExplorerResponse, NetworkError>) -> Void) {
        guard let url = URL(string: self.url) else {
            completion(.failure(.missingURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.taskError))
                return
            }
            guard let data = data else { return }
            guard let decodableData = try? JSONDecoder().decode(ExplorerResponse.self, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success(decodableData))
            return
//            self.bestSellers = self.bestSellerModel(for: decodableData.best_seller)
//            self.homeStore = self.homeStoreModel(for: decodableData.home_store)
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                self.urlSessionImageView.image = image
//            }
        }.resume()
    }
    
    private func bestSellerModel (for bestSeller: [ExplorerResponse.BestSeller]) -> [BestSellerProtocol] {
        bestSeller.map {BestSellerModel(bestSeller: $0)}
    }
    
    private func homeStoreModel (for homeStore: [ExplorerResponse.HomeStore]) -> [HomeStoreProtocol] {
        homeStore.map {HomeStoreModel(homeStore: $0)}
    }
    
    func homeStoreModel(for indexPah: IndexPath) -> HomeStoreProtocol {
        homeStore[indexPah.row]
    }
    
    func bestSellerModel(for indexPah: IndexPath) -> BestSellerProtocol {
        bestSellers[indexPah.row]
    }
}
