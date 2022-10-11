//
//  CategoryCollectionView.swift
//  EffectiveMobile
//
//  Created by  User on 02.09.2022.
//

import UIKit

class CategoryCollectionView: UICollectionView {
    
    let buttonImages = ["phone", "computer", "health", "books"]
    let categoryTitles = ["Phone", "Computer", "Health", "Books"]
    
    init () {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseId)
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumInteritemSpacing = 23
        contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseId, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        cell.setButtonImage(name: buttonImages[indexPath.row])
        cell.setCategoryTitle(title: categoryTitles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 71, height: 93)
    }
}
