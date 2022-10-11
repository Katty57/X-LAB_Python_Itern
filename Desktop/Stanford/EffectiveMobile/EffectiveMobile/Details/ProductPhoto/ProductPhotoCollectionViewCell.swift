//
//  ProductPhotoCollectionViewCell.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class ProductPhotoCollectionViewCell: UICollectionViewCell {
    static let reuseId = "ProductPhotoCollectionViewCell"
    
    lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (details: DetailsModelProtocol?, for index: Int) {
        if let details = details {
            let imageArray = details.images
            productImageView.setImage(source: imageArray[index], placeholder: "photo")
        } else {
            productImageView.image = UIImage(named: "photo")
        }
    }
}
