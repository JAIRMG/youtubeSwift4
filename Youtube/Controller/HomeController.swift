//
//  ViewController.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 06/08/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video] = {
        
        var channel = Channel()
        channel.name = "JairChannel"
        channel.profileImageName = "austintv"
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumbnailImageName = "norway"
        blankSpaceVideo.channel = channel
        blankSpaceVideo.numberOfViews = 342344234234
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Copenhague - DinamarcaCopenhague - Dinamarca"
        badBloodVideo.thumbnailImageName = "copenhague"
        badBloodVideo.channel = channel
        badBloodVideo.numberOfViews = 3423423421341234
        
         return [blankSpaceVideo, badBloodVideo]
        
    }()
    
    func fetchVideos(){
        
        let todoEndpoint: String = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            //Verificar que no exista error
            guard error == nil else{
                print("error")
                return
            }
            
            //Guardando la respuesta
            
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setUpMenuBar()
        setUpBarButtons()
        
    }
    
    func setUpBarButtons(){
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let dotsImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [searchBarButtonItem, moreButton]
        
    }
    
    @objc func handleMore(){
    }
    
    @objc func handleSearch(){
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setUpMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]|", views: menuBar)
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //16 de lado izq y 16 de lado derecho
        let height = (self.view.frame.width - 16 - 16) * 9 / 16
        
        // + 16 por el topPadding y 68 por los objetos que estan debajo del thumbnail (44+16+8)
        return CGSize(width: self.view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

