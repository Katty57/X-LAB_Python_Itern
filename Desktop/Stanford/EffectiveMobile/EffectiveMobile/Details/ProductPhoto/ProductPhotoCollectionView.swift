//
//  ProductPhotoCollectionView.swift
//  EffectiveMobile
//
//  Created by  User on 03.09.2022.
//

import UIKit

class ProductPhotoCollectionView: UICollectionView {
    
    private var presenter: DetailsPresenterProtocol
    
    init (presenter: DetailsPresenterProtocol) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 33
        
        self.presenter = presenter
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(ProductPhotoCollectionViewCell.self, forCellWithReuseIdentifier: ProductPhotoCollectionViewCell.reuseId)
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        
        contentInset = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 70)
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

extension ProductPhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.detailsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: ProductPhotoCollectionViewCell.reuseId, for: indexPath) as? ProductPhotoCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(details: self.presenter.getDetails(), for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 266, height: 335)
    }
}
