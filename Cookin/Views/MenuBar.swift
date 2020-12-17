//
//  MenuBar.swift
//  Cookin
//
//  Created by Owen Medina on 12/17/20.
//

import UIKit

class MenuBar: UIView {
    var numberOfMenuItems: Int?
    var menuItemTitles: [String]?
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        //cv.backgroundColor = .blue
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuBarItemCell.self, forCellWithReuseIdentifier: K.MenuBar.menuBarItemCellIdentifier)
        addSubview(collectionView)
        collectionView.bindFrameToSuperviewBounds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDelegate Methods
extension MenuBar: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource Methods
extension MenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfMenuItems ?? K.MenuBar.defaultNumberOfMenuItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.MenuBar.menuBarItemCellIdentifier, for: indexPath) as! MenuBarItemCell
        if let titles = menuItemTitles {
            cell.label.text = titles[indexPath.row]
        }
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout Methods
extension MenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/CGFloat(numberOfMenuItems ?? K.MenuBar.defaultNumberOfMenuItems), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
