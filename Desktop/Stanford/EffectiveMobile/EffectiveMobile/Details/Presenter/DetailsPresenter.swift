//
//  DetailsPresenter.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

//protocol PresenterViewProtocol: AnyObject {
//    func updateView()
//    func updateView(withLoader isLoading: Bool)
//    func updateView(withError message: String)
//}

protocol DetailsPresenterProtocol {
    var view: ExplorerViewProtocol? {get set}
    var url: String {get}
    var detailsCount: Int {get}
    func loadView()
    func getDetails () -> DetailsModelProtocol?
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    var url: String
    var view: ExplorerViewProtocol?
    var details: DetailsModelProtocol?
    var detailsCount: Int {
        details?.images.count ?? 0
    }
    
    init(url: String) {
        self.url = url
    }
    
    func loadView() {
        getData { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.updateView(withLoader: false)
                
                switch result{
                case .success(let detailsResponse):
                    self?.details = self?.detailsModel(for: detailsResponse)
                    self?.view?.updateView()
//                    if let bestSeller = self?.bestSellerModel(for: explorerResponse.best_seller),
//                    let homeStore = self?.homeStoreModel(for: explorerResponse.home_store) {
//                        self?.bestSellers = bestSeller
//                        self?.homeStore = homeStore
//                        self?.view?.updateView()
//                    }
                case .failure(let error):
                    self?.view?.updateView(withError: error.localizedDescription)
                }
            }
        }
    }
    
    private func getData (completion: @escaping (Result<DetailsResponse, NetworkError>) -> Void) {
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
            guard let decodableData = try? JSONDecoder().decode(DetailsResponse.self, from: data) else {
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
    
    private func detailsModel (for details: DetailsResponse) -> DetailsModelProtocol {
        DetailsModel(details: details)
    }
    
    func getDetails() -> DetailsModelProtocol? {
        details ?? nil
    }
    
//    private func bestSellerModel (for bestSeller: [ExplorerResponse.BestSeller]) -> [BestSellerProtocol] {
//        bestSeller.map {BestSellerModel(bestSeller: $0)}
//    }
//
//    private func homeStoreModel (for homeStore: [ExplorerResponse.HomeStore]) -> [HomeStoreProtocol] {
//        homeStore.map {HomeStoreModel(homeStore: $0)}
//    }
//
//    func homeStoreModel(for indexPah: IndexPath) -> HomeStoreProtocol {
//        homeStore[indexPah.row]
//    }
//
//    func bestSellerModel(for indexPah: IndexPath) -> BestSellerProtocol {
//        bestSellers[indexPah.row]
//    }
}
