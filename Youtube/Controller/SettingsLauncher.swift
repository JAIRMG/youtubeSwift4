//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 13/09/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
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
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
        
        self.blackView.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0.5
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height - 200, width: window.frame.width, height: 200)
        }, completion: nil)
        
        
        
        
    }
    
    
    @objc func handleDismiss(gestureRecognizer: UIGestureRecognizer){
        print("jaja")
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
        }
    }
    
    
    override init() {
        super.init()
    }
}
