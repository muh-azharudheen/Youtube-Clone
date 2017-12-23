//
//  TrendingCell.swift
//  YoutubeClone
//
//  Created by Mac on 12/17/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell{
    
    override func fetchVideos() {
        APIService.sharedInstance.fetchTrendingFeed { (video) in
            self.videos = video
            self.collectionView.reloadData()
        }
    }
    
}
