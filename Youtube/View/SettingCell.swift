//
//  SettingCell.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 17/09/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            print(isHighlighted)
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImage.setImage(UIImage(named: "\(imageName)"), for: .normal)
            }
            
            
        }
    }
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Settings"
        return lb
    }()
    
    let iconImage: UIButton = {
        var image = UIButton()
        image.contentMode = .scaleAspectFill
        image.setImage(UIImage(named: "settings"), for: .normal)
        image.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return image
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        //backgroundColor = UIColor.black
        
        nameLabel.frame = CGRect(x: self.frame.width * 0.15, y: 0, width: self.frame.width * 0.8, height: self.frame.height)
        iconImage.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        
        addSubview(nameLabel)
        addSubview(iconImage)
        
    }
    
    
    
}
