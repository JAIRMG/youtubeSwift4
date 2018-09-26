//
//  ViewController.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 06/08/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    /*var videos: [Video] = {
        
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
        
    }() */
    
    
    var videos: [Video]?
    
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let SubscriptionCellId = "SubscriptionCellId"
    let titles = ["Home","Trending", "Subscriptions","Account"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        
        
        setUpCollectionView()
        setUpMenuBar()
        setUpBarButtons()
        
    }
    
    func setUpCollectionView(){
        
        //Esto hace lo mismo que esta en el appDelegate línea 25
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            //La sig linea quita el espacio que queda entre celdas cuando haces scroll
            flowLayout.minimumLineSpacing = 0
        }
        
        
        collectionView?.backgroundColor = UIColor.white
        
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: SubscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        //Esta linea hace que la celda se detenga al cambiar entre celdas
        collectionView?.isPagingEnabled = true
        
    }
    
    
    
    func setUpBarButtons(){
        let searchImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleMore))
        let dotsImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItems = [searchBarButtonItem, moreButton]
        
    }
    
    @objc func handleSearch(){
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitle(indice: menuIndex)
    }
    
    let settingsLauncher = SettingsLauncher()
    @objc func handleMore(){
        settingsLauncher.showSettings()
    }
    
    private func setTitle(indice: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = titles[indice]
        }
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setUpMenuBar(){
        
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll: ->\(scrollView.contentOffset.x)")
        //Mover la vista blanca del menubar el ancho de la celda / 4
        menuBar.horizontalBarLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Esto nos da el index de la celda (375/375, 750/375...etc)
        print(targetContentOffset.pointee.x / view.frame.width)
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        //titulo
        setTitle(indice: indexPath.row)
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.row == 1{
            identifier = trendingCellId
        } else if indexPath.row == 2 {
            identifier = SubscriptionCellId
        } else {
            identifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        //let colors: [UIColor] = [.blue, .black, .brown, .darkGray]
        //cell.backgroundColor = colors[indexPath.row]
        //titulo
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 65)
    }
    
    
    
}

