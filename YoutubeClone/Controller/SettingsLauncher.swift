//
//  SettingsLauncher.swift
//  YoutubeClone
//
//  Created by Mac on 12/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class Setting{
    let name: SettingName
    let imageName:String
    
    init(name:SettingName, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String{
    case Settings = "Settings"
    case Terms = "Terms & Privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case SwithAccount = "Switch Account"
    case Cancel = "Cancel & Dismiss"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellHeight: CGFloat = 50
    
    var homeController: HomeController?
    
    let settings : [Setting] = {
        return [Setting(name: .Settings, imageName: "settings"),
                Setting(name: .Terms, imageName: "privacy"),
                Setting(name: .Feedback, imageName: "feedback"),
                Setting(name: .Help, imageName: "help"),
                Setting(name: .SwithAccount, imageName: "switch_account"),
                Setting(name: .Cancel, imageName: "cancel")]
    }()
    
    let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        cv.isScrollEnabled = true
        return cv
    }()
    
    let cellId = "cellId"
    
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    let blackView = UIView()
    
    func showSettingLauncher(){
        // show menu
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            
            let height: CGFloat = cellHeight * CGFloat(settings.count)
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.width)
                self.blackView.alpha = 1
            }, completion: nil)
            
        }
    }
    
    @objc func handleDismiss(){
        dismissMenu(setting: nil)
    }
    
    private func dismissMenu(setting: Setting?){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (complete) in
            if let set = setting{
                if set.name != .Cancel{
                self.homeController?.showControllerForSetting(setting: set)
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        dismissMenu(setting: settings[indexPath.item])
    }
    
}





