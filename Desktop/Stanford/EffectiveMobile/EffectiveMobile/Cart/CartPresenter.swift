//
//  CartPresenter.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

protocol CartPresenterProtocol {
    var view: ExplorerViewProtocol? {get set}
    var url: String {get}
    var cart: CartModelProtocol? {get}
    var basket: [ProductModelProtocol] {get}
    var productCount: Int {get}
    func loadView()
    func productModel(for indexPah: IndexPath) -> ProductModelProtocol 
}

class CartPresenter: CartPresenterProtocol {
    
    var url: String
    var view: ExplorerViewProtocol?
    var cart: CartModelProtocol?
    var basket: [ProductModelProtocol] = []
    var productCount: Int {
        basket.count
    }
    
    init(url: String) {
        self.url = url
    }
    
    func loadView() {
        getData { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.updateView(withLoader: false)
                
                switch result{
                case .success(let cartResponse):
                    self?.cart = self?.cartModel(for: cartResponse)
                    if let products = self?.productModel(for: cartResponse.basket) {
                        self?.basket = products
                        self?.view?.updateView()
                    }
                case .failure(let error):
                    self?.view?.updateView(withError: error.localizedDescription)
                }
            }
        }
    }
    
    private func getData (completion: @escaping (Result<CartResponse, NetworkError>) -> Void) {
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
            guard let decodableData = try? JSONDecoder().decode(CartResponse.self, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success(decodableData))
            return
        }.resume()
    }
    
    private func cartModel (for cart: CartResponse) -> CartModelProtocol {
        CartModel(cart: cart)
    }
    
    private func productModel (for products: [CartResponse.ProductResponse]) -> [ProductModelProtocol] {
        products.map {ProductModel(product: $0)}
    }
    
    func productModel(for indexPah: IndexPath) -> ProductModelProtocol {
        basket[indexPah.row]
    }
}
