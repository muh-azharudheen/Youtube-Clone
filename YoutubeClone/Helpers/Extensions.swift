//
//  Extensions.swift
//  YoutubeClone
//
//  Created by Mac on 12/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView{
    func addConstraintWithFormat(format: String,options:NSLayoutFormatOptions = NSLayoutFormatOptions(), views: UIView...){
        var dictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            dictionary["v\(index)"] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: nil, views: dictionary))
    }
}


let imageCache =  NSCache<NSString,UIImage>()

class customImageView:UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data) {
                    
                    if self.imageUrlString == urlString{
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }
        }.resume()
    }
}
