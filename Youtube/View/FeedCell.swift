//
//  FeedCell.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 24/09/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var videos: [Video]?
    
    func fetchVideos(){
        
        /*ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        } */
        
        ApiService.sharedInstance.fetchForUrlString(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
    
    override func setUpViews() {
        super.setUpViews()
        fetchVideos()
        
        backgroundColor = UIColor.white
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        addSubview(collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
     return videos?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
     
     cell.video = videos?[indexPath.item]
     
     return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     //16 de lado izq y 16 de lado derecho
     let height = (frame.width - 16 - 16) * 9 / 16
     
     // + 16 por el topPadding y 68 por los objetos que estan debajo del thumbnail (44+16+8)
     return CGSize(width: frame.width, height: height + 16 + 88)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
     return 0
     }
    

}
