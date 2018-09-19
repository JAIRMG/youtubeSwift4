//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 13/09/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit


class Setting: NSObject {
    let name: String
    let imageName: String
    
     init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
        }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"),
                Setting(name: "Terms & privacy", imageName: "settings"),
                Setting(name: "Send feedback", imageName: "settings"),
                Setting(name: "Help", imageName: "settings"),
                Setting(name: "Switch account", imageName: "settings"),
                Setting(name: "Cancel", imageName: "settings")]
    }()
    
    @objc func showSettings(){
        
        blackView.backgroundColor = UIColor.black
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        blackView.frame = CGRect(x: window.frame.origin.x, y:window.frame.origin.y - UIApplication.shared.statusBarFrame.height , width: window.frame.width, height: window.frame.height)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss(gestureRecognizer:)))
        blackView.addGestureRecognizer(tap)
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: CGFloat(settings.count) * cellHeight)
        
        self.blackView.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0.5
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height - CGFloat(self.settings.count) * self.cellHeight, width: window.frame.width, height: CGFloat(self.settings.count) * self.cellHeight)
        }, completion: nil)
        
        
        
        
    }
    
    
    @objc func handleDismiss(gestureRecognizer: UIGestureRecognizer){
        print("jaja")
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: CGFloat(self.settings.count) * self.cellHeight)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override init() {
        super.init()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
}
