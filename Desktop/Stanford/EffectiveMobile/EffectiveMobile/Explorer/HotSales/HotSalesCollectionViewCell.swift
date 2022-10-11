//
//  HotSalesCollectionViewCell.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class HotSalesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "HotSalesCollectionViewCell"
    
    lazy var hotSalesImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .magenta
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func configure (hotSales: HomeStoreProtocol) {
        hotSalesImageView.setImage(source: hotSales.picture, placeholder: "photo")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(hotSalesImageView)
        NSLayoutConstraint.activate([
            hotSalesImageView.topAnchor.constraint(equalTo: topAnchor),
            hotSalesImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hotSalesImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hotSalesImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
