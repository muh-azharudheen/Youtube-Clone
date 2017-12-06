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
    func addConstraintWithFormat(format: String, views: UIView...){
        var dictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            dictionary["v\(index)"] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
    }
}
