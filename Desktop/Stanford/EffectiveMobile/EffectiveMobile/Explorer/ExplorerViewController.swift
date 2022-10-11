//
//  ViewController.swift
//  EffectiveMobile
//
//  Created by  User on 22.08.2022.
//

import UIKit

class ExplorerViewController: UIViewController {
    
    private let presenter: ExplorerPresenterProtocol
    
    init(presenter: ExplorerPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var categoryHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Select Category"
        label.font = UIFont(name: "MarkPro-Bold", size: 25)
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 15)
        button.setTitle("see all", for: .normal)
        button.addTarget(self, action: #selector(openDetails), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1), for: .normal)
        
        view.addSubview(label)
        view.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 203),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 52)
        ])
        return view
    }()
    
    lazy var categoryView: UICollectionView = {
        let view = CategoryCollectionView()
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImageView(image: UIImage(named: "search"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            image.heightAnchor.constraint(equalToConstant: 16),
            image.widthAnchor.constraint(equalToConstant: 16),
            
            textField.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 6),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 15)
        ])
        return view
    }()
    
    lazy var qrButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "qr")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 14
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var hotSalesHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Hot sales"
        label.font = UIFont(name: "MarkPro-Bold", size: 25)
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 15)
        button.setTitle("see more", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1), for: .normal)
        
        view.addSubview(label)
        view.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 203),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 74)
        ])
        return view
    }()
    
    lazy var hotSalesView: UICollectionView = {
        let view = HotSalesCollectionView(presenter: self.presenter)
        return view
    }()
    
    lazy var bestSellerHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Best Seller"
        label.font = UIFont(name: "MarkPro-Bold", size: 25)
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 15)
        button.setTitle("see more", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1), for: .normal)
        
        view.addSubview(label)
        view.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 203),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 74)
        ])
        return view
    }()
    
    lazy var bestSellerView: UICollectionView = {
        let view = BestSellerCollectionView(presenter: self.presenter)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadView()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 119, height: 19))
        let geoLabel = UILabel()
        geoLabel.text = "Zihuatanejo, Gro"
        geoLabel.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        geoLabel.font = UIFont(name: "MarkPro-Medium", size: 15)
        
        let filterButton = UIBarButtonItem()
        filterButton.image = UIImage(named: "filter")
        filterButton.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        navigationItem.rightBarButtonItem = filterButton
        titleView.addSubview(geoLabel)
        
        geoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            geoLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            geoLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        navigationItem.titleView = titleView
        
        view.addSubview(categoryHeaderView)
        view.addSubview(categoryView)
        view.addSubview(searchBar)
        view.addSubview(qrButton)
        view.addSubview(hotSalesHeaderView)
        view.addSubview(hotSalesView)
        view.addSubview(bestSellerHeaderView)
        view.addSubview(bestSellerView)
        
        NSLayoutConstraint.activate([
            categoryHeaderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 101),
            categoryHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            categoryHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            categoryHeaderView.heightAnchor.constraint(equalToConstant: 32),
            
            categoryView.topAnchor.constraint(equalTo: categoryHeaderView.bottomAnchor, constant: 24),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: 93),
            
            searchBar.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 35),
            searchBar.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor, constant: 32),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -82),
            searchBar.heightAnchor.constraint(equalToConstant: 34),
            
            qrButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 15),
            qrButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            qrButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            qrButton.heightAnchor.constraint(equalTo: qrButton.widthAnchor),
            
            hotSalesHeaderView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 24),
            hotSalesHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            hotSalesHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            hotSalesHeaderView.heightAnchor.constraint(equalToConstant: 32),
            
            hotSalesView.topAnchor.constraint(equalTo: hotSalesHeaderView.bottomAnchor, constant: 8),
            hotSalesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotSalesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotSalesView.heightAnchor.constraint(equalToConstant: 182),
            
            bestSellerHeaderView.topAnchor.constraint(equalTo: hotSalesView.bottomAnchor, constant: 11),
            bestSellerHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            bestSellerHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            bestSellerHeaderView.heightAnchor.constraint(equalToConstant: 32),
            
            bestSellerView.topAnchor.constraint(equalTo: bestSellerHeaderView.bottomAnchor, constant: 16),
            bestSellerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bestSellerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bestSellerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -96)
        ])
    }

    @objc func openDetails (sender _: UIButton) {
        let presenter = DetailsPresenter(url: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")
        let vc = DetailsViewController(presenter: presenter)
        presenter.view = vc
        self.navigationController?.pushViewController(vc, animated: false)
    }

}

extension ExplorerViewController: ExplorerViewProtocol {
    
    func updateView() {
        self.hotSalesView.reloadData()
        self.bestSellerView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        errorAlert.addAction(ok)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
