//
//  VideoCell.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 24/08/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.title
            
            
            setUpThumbNailImage()
            
            setUpProfileImage()
            
            /*if let profileImageName = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImageName)
            }*/
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                
                
                let subtitleText = "\(channelName) + \(numberFormatter.string(from: numberOfViews)!) + 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightCostraint?.constant = 44
                } else {
                    titleLabelHeightCostraint?.constant = 20
                }
                
            }
            
            
            
            
            
        }
    }
    
    func setUpProfileImage(){
        
        if let profileImageURL = video?.channel?.profileImageName{
         self.userProfileImageView.loadImageUsinUrlString(urlString: profileImageURL)
        }
        
    }
    
    func setUpThumbNailImage(){
        
        if let thumnailImageURL = video?.thumbnailImageName{
            self.thumbnailImageView.loadImageUsinUrlString(urlString: thumnailImageURL)
        }
        
        //thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
        
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "norway")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "tessa")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tessa Ia"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "JairVEVO - 1.1M"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightCostraint: NSLayoutConstraint?
    
    override func setUpViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        
        
        //Usando una extensión:
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)
        //addConstraintsWithFormat(format: "V:[v0(1)]|", views: separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top , relatedBy: .equal , toItem: thumbnailImageView, attribute: .bottom , multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left , relatedBy: .equal , toItem: userProfileImageView, attribute: .right , multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right , relatedBy: .equal , toItem: thumbnailImageView, attribute: .right , multiplier: 1, constant: 0))
        //height constraint
        titleLabelHeightCostraint = NSLayoutConstraint(item: titleLabel, attribute: .height , relatedBy: .equal , toItem: self, attribute: .height , multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightCostraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top , relatedBy: .equal , toItem: titleLabel, attribute: .bottom , multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left , relatedBy: .equal , toItem: userProfileImageView, attribute: .right , multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right , relatedBy: .equal , toItem: thumbnailImageView, attribute: .right , multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height , relatedBy: .equal , toItem: self, attribute: .height , multiplier: 0, constant: 30))
        
        //addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        //addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        
        
    }
    
    
}
