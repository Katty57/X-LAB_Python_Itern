//
//  CategoryCollectionViewCell.swift
//  EffectiveMobile
//
//  Created by  User on 02.09.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CategoryCollectionViewCell"
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 0.702, green: 0.702, blue: 0.765, alpha: 1)
        button.backgroundColor = .white
        button.layer.cornerRadius = 71 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1)
        label.font = UIFont(name: "MarkPro-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setButtonImage (name: String) {
        categoryButton.setImage(UIImage(named: name)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    func setCategoryTitle (title: String) {
        categoryLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryButton)
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: topAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 71),
            categoryButton.widthAnchor.constraint(equalToConstant: 71),
            
            categoryLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 7),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
