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
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        title = "  \(titles[0])"
        
        setupMenubar()
        setupNavBarButtons()
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
    }
    
    private func setupMenubar(){
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        self.view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
        
        let guide = view.safeAreaLayoutGuide
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.hidesBarsOnSwipe = true
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
    
    func scorollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0 )
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        setTitleForIndex(index: menuIndex)
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
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) 	
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
 
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        setTitleForIndex(index: Int(item))
        
    }
    
    private func setTitleForIndex(index: Int){
        if let titleLbl = navigationItem.titleView as? UILabel{
            titleLbl.text = titles[index]
        }
    }
    
}



