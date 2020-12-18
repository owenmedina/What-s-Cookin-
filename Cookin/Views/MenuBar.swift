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
    private var horizontalBarXConstraint: NSLayoutConstraint?
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
        
        setupHorizontalBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHorizontalBar() {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = K.Assets.Colors.orange
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBar)
        
        // Setup constraints
        horizontalBarXConstraint = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarXConstraint?.isActive = true // set the x of the horizontal bar
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true // set the y of the horizontal bar
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: K.MenuBar.horizontalBarHeight).isActive = true
    }
    
    fileprivate func moveHorizontalBar(to x: CGFloat) {
        // Change the value of the constraint. Do not add a new one.
        horizontalBarXConstraint?.constant = x
        // Animate for sliding effect from item to item
        UIView.animate(withDuration: K.Animation.mediumDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { self.layoutIfNeeded() }, completion: nil)
    }
}

//MARK: - UICollectionViewDelegate Methods
extension MenuBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newXPosition = CGFloat(indexPath.item) * (CGFloat(collectionView.frame.width)/CGFloat(numberOfMenuItems ?? K.MenuBar.defaultNumberOfMenuItems))
        moveHorizontalBar(to: newXPosition)
    }
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
