//
//  Extensions.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 24/08/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit



extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for(index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()


class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsinUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else{
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = UIImage(data: data!)
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                
                
            }
            
            }.resume()
        
    }
}
