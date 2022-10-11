//
//  CartViewController.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    private var presenter: CartPresenterProtocol
    
    init(presenter: CartPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        return tableView
    }()
    
    lazy var cartTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.font = UIFont(name: "MarkPro-Bold", size: 35)
        label.text = "My Cart"
        return label
    }()
    
    lazy var totalPriceView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bigLineView = UIView()
        bigLineView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        bigLineView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleStackView = UIStackView()
        titleStackView.alignment = .fill
        titleStackView.axis = .vertical
        titleStackView.spacing = 12
        titleStackView.distribution = .fillEqually
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleArray = ["Total", "Delivery"].map {title in
            createLabel(title: title, font: UIFont(name: "MarkPro-Regular", size: 15) ?? .systemFont(ofSize: 15))
        }
        
        titleArray.forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        let numberStackView = UIStackView()
        numberStackView.alignment = .fill
        numberStackView.axis = .vertical
        numberStackView.spacing = 12
        numberStackView.distribution = .fillEqually
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let numberArray = ["$6,000 us", "Free"].map {title in
            createLabel(title: title, font: UIFont(name: "MarkPro-Bold", size: 15) ?? .systemFont(ofSize: 15))
        }
        
        var iter = 0
        numberArray.forEach {
            numberStackView.addArrangedSubview($0)
            $0.tag = iter
            iter += 1
        }
        
        view.addSubview(bigLineView)
        view.addSubview(titleStackView)
        view.addSubview(numberStackView)
        NSLayoutConstraint.activate([
            bigLineView.topAnchor.constraint(equalTo: view.topAnchor),
            bigLineView.heightAnchor.constraint(equalToConstant: 2),
            bigLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            bigLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            titleStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            titleStackView.widthAnchor.constraint(equalToConstant: 194),
            
            numberStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            numberStackView.leadingAnchor.constraint(equalTo: titleStackView.trailingAnchor, constant: 19),
        ])
        
        return view
    }()
    
    lazy var checkoutButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        
        let smallLineView = UIView()
        smallLineView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        smallLineView.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Checkout"
        label.font = UIFont(name: "MarkPro-Bold", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(label)
        view.addSubview(button)
        view.addSubview(smallLineView)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            
            smallLineView.topAnchor.constraint(equalTo: view.topAnchor),
            smallLineView.heightAnchor.constraint(equalToConstant: 1),
            smallLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            smallLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
        ])
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadView()

        let navBarView = UIView()
        
        let title = UILabel()
        title.text = "Add address"
        title.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        title.font = UIFont(name: "MarkPro-Medium", size: 18)
        title.textAlignment = .left
        
        let backButtonView = UIView()
        backButtonView.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        backButtonView.layer.cornerRadius = 10
        backButtonView.clipsToBounds = true
//        let backButtonImage = UIImageView(image: UIImage(named: "back-arrow"))
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        
        let locationButtonView = UIView()
        locationButtonView.backgroundColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        locationButtonView.layer.cornerRadius = 10
        locationButtonView.clipsToBounds = true
//        let locationButtonImage = UIImageView(image: UIImage(named: "location"))
        let locationButton = UIButton()
        locationButton.setImage(UIImage(named: "location"), for: .normal)
        locationButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        locationButtonView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButtonView.addSubview(backButton)
        locationButtonView.addSubview(locationButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: backButtonView.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor),

            locationButton.centerXAnchor.constraint(equalTo: locationButtonView.centerXAnchor),
            locationButton.centerYAnchor.constraint(equalTo: locationButtonView.centerYAnchor)
        ])
        
        navBarView.addSubview(backButtonView)
        navBarView.addSubview(locationButtonView)
        navBarView.addSubview(title)
        NSLayoutConstraint.activate([
            navBarView.widthAnchor.constraint(equalToConstant: 309),
            navBarView.heightAnchor.constraint(equalToConstant: 37),
            
            backButtonView.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            backButtonView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            backButtonView.widthAnchor.constraint(equalToConstant: 37),
            backButtonView.heightAnchor.constraint(equalToConstant: 37),
            
            locationButtonView.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            locationButtonView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            locationButtonView.widthAnchor.constraint(equalToConstant: 37),
            locationButtonView.heightAnchor.constraint(equalToConstant: 37),
            
            title.trailingAnchor.constraint(equalTo: locationButtonView.leadingAnchor, constant: -9),
            title.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
        ])
        
        navigationItem.titleView = navBarView
        
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.hidesBackButton = true
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        view.addSubview(cartTitleLabel)
        view.addSubview(cartTableView)
        view.addSubview(totalPriceView)
        view.addSubview(checkoutButtonView)
        NSLayoutConstraint.activate([
            cartTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 166),
            cartTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            
            cartTableView.topAnchor.constraint(equalTo: cartTitleLabel.bottomAnchor, constant: 49),
            cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -216),
            
            totalPriceView.topAnchor.constraint(equalTo: cartTableView.bottomAnchor),
            totalPriceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalPriceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalPriceView.heightAnchor.constraint(equalToConstant: 91),
            
            checkoutButtonView.topAnchor.constraint(equalTo: totalPriceView.bottomAnchor),
            checkoutButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            checkoutButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkoutButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func popToPreviousVC (sender _: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func createLabel (title: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = font
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func configure () {
        let totalPriceSubviews = totalPriceView.subviews
        for subview in totalPriceSubviews {
            if subview.tag == 0, let totalLabel = subview as? UILabel {
                totalLabel.text = presenter.cart?.total
            } else if subview.tag == 1, let deliveryLabel = subview as? UILabel {
                deliveryLabel.text = presenter.cart?.delivery
            }
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.productCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.reuseId, for: indexPath) as? CartTableViewCell else {return UITableViewCell()}
        cell.configure(product: presenter.productModel(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        view.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        return view
    }
    
}

extension CartViewController: ExplorerViewProtocol {
    func updateView() {
        self.cartTableView.reloadData()
        self.configure()
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
