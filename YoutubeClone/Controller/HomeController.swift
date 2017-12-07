//
//  ViewController.swift
//  YoutubeClone
//
//  Created by Mac on 12/6/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    
    fileprivate let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        title = "Home"
        collectionView?.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenubar()
        
    }
    
    private func setupMenubar(){
        self.view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight = (view.frame.width - 32) * 9/16
        let balanceHeight:CGFloat = 85
        
        return CGSize(width: view.frame.width, height: imageHeight + balanceHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}










