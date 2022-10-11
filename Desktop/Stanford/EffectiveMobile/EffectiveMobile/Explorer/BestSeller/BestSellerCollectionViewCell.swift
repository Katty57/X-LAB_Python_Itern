//
//  BestSellerCollectionViewCell.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class BestSellerCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "BestSellerCollectionViewCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .cyan
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.font = UIFont(name: "MarkPro-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$1,047"
        return label
    }()
    
    lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        label.font = UIFont(name: "MarkPro-Medium", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "Your Text")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        label.attributedText = attributeString
        
        label.text = "$1,500"
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        label.font = UIFont(name: "MarkPro-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Samsung Galaxy s20 Ultra"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        
        addSubview(image)
        addSubview(newPriceLabel)
        addSubview(oldPriceLabel)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 168),
            
            newPriceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2),
            newPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            
            oldPriceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            oldPriceLabel.leadingAnchor.constraint(equalTo: newPriceLabel.trailingAnchor, constant: 7),
            
            nameLabel.topAnchor.constraint(equalTo: newPriceLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (bestSeller: BestSellerProtocol) {
        image.setImage(source: bestSeller.picture, placeholder: "photo")
        nameLabel.text = bestSeller.title
        newPriceLabel.text = bestSeller.price_without_discount
        oldPriceLabel.text = bestSeller.discount_price
    }
}
