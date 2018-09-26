//
//  TrendingCell.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 26/09/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    
    override func fetchVideos() {
      
        /*ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        } */
        
        ApiService.sharedInstance.fetchForUrlString(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json") { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
    
}
