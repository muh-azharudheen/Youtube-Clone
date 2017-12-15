//
//  FeedCell.swift
//  YoutubeClone
//
//  Created by Mac on 12/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class FeedCell: BaseCell{
    
   
    
    fileprivate var videos: [Video]?
    
    fileprivate let cellId = "cellId"
    
    lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.brown
        
        addSubview(collectionView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchVideos()
        
    }
    
    
    func fetchVideos(){
        APIService.sharedInstance.fetchVideos { (video) in
            self.videos = video
            self.collectionView.reloadData()
        }
    }
}


extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight = (frame.width - 16 - 16 ) * 9/16
        let balanceHeight:CGFloat = 85 + 16
    
        return CGSize(width: frame.width, height: imageHeight + balanceHeight)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}











