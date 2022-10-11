//
//  DetailsViewController.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private var presenter: DetailsPresenterProtocol
    
    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var productPhotoCollectionView: UICollectionView = {
        let collectionView = ProductPhotoCollectionView(presenter: self.presenter)
        return collectionView
    }()
    
    lazy var detailsView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let name = UILabel()
        name.text = "Galaxy Note 20 Ultra"
        name.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        name.font = UIFont(name: "MarkPro-Medium", size: 24)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        let favouriteButton = UIButton()
        favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
        favouriteButton.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        favouriteButton.layer.cornerRadius = 10
        favouriteButton.clipsToBounds = true
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        let starStackView = addStars(count: 5)
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let detailsStackView = UIStackView()
        detailsStackView.alignment = .fill
        detailsStackView.axis = .horizontal
        detailsStackView.spacing = 30
        detailsStackView.distribution = .fillEqually
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false

        let buttonsArray = ["Shop", "Details", "Features"].map {title in
            createMenuButton(title: title)
        }

        var iter = 0
        buttonsArray.forEach {
            detailsStackView.addArrangedSubview($0)
            $0.tag = iter
            iter += 1
        }
        
        let infoStackView = UIStackView()
        infoStackView.alignment = .fill
        infoStackView.axis = .horizontal
        infoStackView.spacing = 30
        infoStackView.distribution = .fillEqually
        infoStackView.translatesAutoresizingMaskIntoConstraints = false


        let infoArray = ["chip" : "Exynos 990",
                         "camera-details" : "108 + 12 mp",
                         "rom" : "8 GB",
                         "ram" : "256 GB"
        ].map {item in
            createInfoView(feature: item.key, info: item.value)
        }

        infoArray.forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        let colorCapacityLabel = UILabel()
        colorCapacityLabel.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        colorCapacityLabel.font = UIFont(name: "MarkPro-Medium", size: 16)
        colorCapacityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let colorChooseStackView = UIStackView()
        colorChooseStackView.alignment = .fill
        colorChooseStackView.axis = .horizontal
        colorChooseStackView.spacing = 18
        colorChooseStackView.distribution = .fillEqually
        colorChooseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let colorArray = [
            UIColor(red: 0.467, green: 0.175, blue: 0.012, alpha: 1),
            UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        ].map {color in
            createColorPickerButton(color: color)
        }
        
        colorArray.forEach {
            colorChooseStackView.addArrangedSubview($0)
        }
        
        let capacityChooseStackView = UIStackView()
        capacityChooseStackView.alignment = .fill
        capacityChooseStackView.axis = .horizontal
        capacityChooseStackView.spacing = 5
        capacityChooseStackView.distribution = .fillEqually
        capacityChooseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let capacityArray = [ "128 GB", "256 gb"].map {title in
            createCapacityPickerButton(title: title)
        }
        
        capacityArray.forEach {
            capacityChooseStackView.addArrangedSubview($0)
        }
        
        let addToCartButton = UIButton()
        addToCartButton.backgroundColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        addToCartButton.clipsToBounds = true
        addToCartButton.layer.cornerRadius = 10
        
        let addToCartLabel = UILabel()
        addToCartLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        addToCartLabel.font = UIFont(name: "MarkPro-Bold", size: 20)
        addToCartLabel.text = "Add To Cart"
        addToCartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let priceLabel = UILabel()
        priceLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        priceLabel.font = UIFont(name: "MarkPro-Bold", size: 20)
        priceLabel.text = "$1,500.00"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addToCartButton.addSubview(addToCartLabel)
        addToCartButton.addSubview(priceLabel)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addToCartLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 45),
            addToCartLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor, constant: -38),
            priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
        ])
        
        view.addSubview(name)
        view.addSubview(favouriteButton)
        view.addSubview(starStackView)
        view.addSubview(infoStackView)
        view.addSubview(detailsStackView)
        view.addSubview(colorCapacityLabel)
        view.addSubview(colorChooseStackView)
        view.addSubview(capacityChooseStackView)
        view.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            
            favouriteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
            favouriteButton.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 58),
            favouriteButton.heightAnchor.constraint(equalToConstant: 33),
            favouriteButton.widthAnchor.constraint(equalToConstant: 37),
            
            starStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 7),
            starStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            starStackView.heightAnchor.constraint(equalToConstant: 18),
            
            detailsStackView.topAnchor.constraint(equalTo: starStackView.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            detailsStackView.heightAnchor.constraint(equalToConstant: 41),
            
            infoStackView.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 28),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            infoStackView.heightAnchor.constraint(equalToConstant: 52),
            
            colorCapacityLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 28),
            colorCapacityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            colorChooseStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            colorChooseStackView.topAnchor.constraint(equalTo: colorCapacityLabel.topAnchor, constant: 14),
            colorChooseStackView.widthAnchor.constraint(equalToConstant: 98),
            colorChooseStackView.heightAnchor.constraint(equalToConstant: 40),
            
            capacityChooseStackView.leadingAnchor.constraint(equalTo: colorChooseStackView.trailingAnchor, constant: 58),
            capacityChooseStackView.centerYAnchor.constraint(equalTo: colorChooseStackView.centerYAnchor),
            capacityChooseStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            capacityChooseStackView.heightAnchor.constraint(equalToConstant: 30),
            
            addToCartButton.topAnchor.constraint(equalTo: colorChooseStackView.bottomAnchor, constant: 27),
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29),
            addToCartButton.heightAnchor.constraint(equalToConstant: 54),
            addToCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58)
            
        ])
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadView()
        
        let navBarView = UIView()
        
        let title = UILabel()
        title.text = "Product Details"
        title.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        title.font = UIFont(name: "MarkPro-Medium", size: 18)
        
        let backButtonView = UIView()
        backButtonView.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        backButtonView.layer.cornerRadius = 10
        backButtonView.clipsToBounds = true
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        
        let cartButtonView = UIView()
        cartButtonView.backgroundColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        cartButtonView.layer.cornerRadius = 10
        cartButtonView.clipsToBounds = true
        let cartButton = UIButton()
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(openCartViewController), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        cartButtonView.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButtonView.addSubview(backButton)
        cartButtonView.addSubview(cartButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: backButtonView.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor),

            cartButton.centerXAnchor.constraint(equalTo: cartButtonView.centerXAnchor),
            cartButton.centerYAnchor.constraint(equalTo: cartButtonView.centerYAnchor)
        ])
        
        navBarView.addSubview(backButtonView)
        navBarView.addSubview(cartButtonView)
        navBarView.addSubview(title)
        NSLayoutConstraint.activate([
            navBarView.widthAnchor.constraint(equalToConstant: 309),
            navBarView.heightAnchor.constraint(equalToConstant: 37),
            
            title.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
            backButtonView.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            backButtonView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            backButtonView.widthAnchor.constraint(equalToConstant: 37),
            backButtonView.heightAnchor.constraint(equalToConstant: 37),
            
            cartButtonView.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            cartButtonView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            cartButtonView.widthAnchor.constraint(equalToConstant: 37),
            cartButtonView.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        navigationItem.titleView = navBarView
        
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.hidesBackButton = true
        
        view.addSubview(productPhotoCollectionView)
        NSLayoutConstraint.activate([
            productPhotoCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 146),
            productPhotoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productPhotoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productPhotoCollectionView.heightAnchor.constraint(equalToConstant: 349)
        ])
        
        view.addSubview(detailsView)
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: productPhotoCollectionView.bottomAnchor, constant: 7),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func addStars (count: Int) -> UIStackView {
        let view = UIStackView()
        view.alignment = .fill
        view.spacing = 9
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        for _ in 0..<count {
            let button  = UIButton()
            button.setImage(UIImage(named: "star"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 18),
                button.widthAnchor.constraint(equalToConstant: 18)
            ])
            
            view.addArrangedSubview(button)
        }
        
        return view
    }
    
    func createMenuButton(title: String) -> UIButton{
        let button = UIButton()
        
        let label = UILabel()
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.font = UIFont(name: "MarkPro-Bold", size: 20)
        label.text = title
        
        button.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        return button
    }

    func createInfoView (feature: String, info: String) -> UIView {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false

        let image = UIImageView(image: UIImage(named: feature))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIView()
        imageView.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        
        imageView.addSubview(image)

        let infoLabel = UILabel()
        infoLabel.text = info
        infoLabel.textColor = UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)
        infoLabel.font = UIFont(name: "MarkPro-Regular", size: 11)
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addArrangedSubview(imageView)
        view.addArrangedSubview(infoLabel)

        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 38),

        ])

        return view
    }
    
    func createColorPickerButton(color: UIColor) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "select-color"), for: .selected)
        button.backgroundColor = color
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createCapacityPickerButton (title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "MarkPro-Bold", size: 13)
        label.text = title
        label.textAlignment = .center
        
        button.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        return button
    }
    
    @objc func openCartViewController (sender _: UIButton) {
        let presenter = CartPresenter(url: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")
        let vc = CartViewController(presenter: presenter)
        presenter.view = vc
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func popToPreviousVC (sender _: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
}

extension DetailsViewController: ExplorerViewProtocol {
    func updateView() {
        self.productPhotoCollectionView.reloadData()
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
