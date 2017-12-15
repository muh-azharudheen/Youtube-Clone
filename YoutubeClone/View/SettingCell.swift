//
//  SettingCell.swift
//  YoutubeClone
//
//  Created by Mac on 12/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class SettingCell: BaseCell{
    
    var setting: Setting?{
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted  ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted  ? UIColor.white : UIColor.darkGray
        }
    }
    
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isSelected ? UIColor.white : UIColor.black
            iconImageView.tintColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "setting"
        return label
    }()
    
    let iconImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "settings")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|",options: .alignAllCenterY, views: iconImageView,nameLabel )
        addConstraintWithFormat(format: "V:|-10-[v0(30)]", views: iconImageView)
        
        
    }
}
