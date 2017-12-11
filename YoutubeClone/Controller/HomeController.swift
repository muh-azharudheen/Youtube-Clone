//
//  ViewController.swift
//  YoutubeClone
//
//  Created by Mac on 12/6/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var videos : [Video]?
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func fetchVideos(){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]] {
                    self.videos = [Video]()
                    for dictionary in json {
                        let video = Video()
                        video.title = dictionary["title"] as? String
                        video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                        let channel = Channel()
                        let channelDictionry = dictionary["channel"] as! [String: AnyObject]
                        channel.name = channelDictionry["name"] as? String
                        channel.profileImageName = channelDictionry["profile_image_name"] as? String
                        video.channel = channel
                        self.videos?.append(video)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                
            } catch let JsonError {
                print(JsonError)
            }
            
            
            
            }.resume()
    }
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        title = "Home"
        collectionView?.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenubar()
        setupNavBarButtons()
        
    }
    
    private func setupMenubar(){
        self.view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    private func setupNavBarButtons(){
        let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(HomeController.handleSearch(_:)))
        navigationItem.rightBarButtonItems = [searchBarButtonItem, moreButton]
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc private func handleSearch(_ sender: UIBarButtonItem){
        settingsLauncher.showSettingLauncher()
    }
    
    @objc private func handleMore(){
        
    }
    
    func showControllerForSetting(setting: Setting){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight = (view.frame.width - 32) * 9/16
        let balanceHeight:CGFloat = 85 + 16
        
        return CGSize(width: view.frame.width, height: imageHeight + balanceHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



