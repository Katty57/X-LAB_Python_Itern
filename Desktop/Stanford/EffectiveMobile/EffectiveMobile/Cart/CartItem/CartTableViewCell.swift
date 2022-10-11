//
//  CartTableViewCell.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    static let reuseId = "CartTableViewCell"
    
    lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .purple
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Galaxy Note 20 Ultra"
        label.textColor = .white
        label.font = UIFont(name: "MarkPro-Medium", size: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$3000.00"
        label.textColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        label.font = UIFont(name: "MarkPro-Medium", size: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var countView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fillEqually
        view.layer.cornerRadius = 13
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0.158, green: 0.156, blue: 0.262, alpha: 1)
        
        let minusButton = UIButton()
        minusButton.setImage(UIImage(named: "minus"), for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "2"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "MarkPro-Medium", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let plusButton = UIButton()
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addArrangedSubview(minusButton)
        view.addArrangedSubview(label)
        view.addArrangedSubview(plusButton)
        
        return view
    }()
    
    lazy var basketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "delete"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countView)
        contentView.addSubview(basketButton)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.5),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            productImageView.heightAnchor.constraint(equalToConstant: 88),
            productImageView.widthAnchor.constraint(equalToConstant: 88),
//            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22.5),
            
            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 17),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.widthAnchor.constraint(equalToConstant: 153),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.5),
            
            countView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 33),
            countView.widthAnchor.constraint(equalToConstant: 26),
            
            basketButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            basketButton.leadingAnchor.constraint(equalTo: countView.trailingAnchor, constant: 17)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure (product: ProductModelProtocol) {
        productImageView.setImage(source: product.images, placeholder: "photo")
        nameLabel.text = product.title
        priceLabel.text = product.price
    }

}
