//
//  SidebarCollectionViewController.swift
//  UITabBarSplitView Test App
//
//  Created by Frederik Riedel on 06.01.22.
//

#if os(iOS)
import UIKit


protocol SidebarCollectionViewControllerDelegate {
    func didChangeSideBar(index: Int)
}

@available(iOS 14.0, *)
class SidebarCollectionViewController: UICollectionViewController {
    
    var delegate: SidebarCollectionViewControllerDelegate?
    
    var selectedIndex = 0 {
        didSet {
            self.collectionView.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .top)
        }
    }
    
    var tabBarItems = [UITabBarItem]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        let dictionary = Bundle.main.infoDictionary!
        let appName = dictionary["CFBundleName"] as! String
        self.title = appName
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        
        
        
//        self.collectionView.contentInset = UIEdgeInsets(top: self.navigationController!.navigationBar.frame.height, left: 0, bottom: 0, right: 0)
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationController?.navigationBar.isHidden = false
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(openMenu))
//
//
//        self.toolbarItems = [
//            UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(openSettings)),
//            UIBarButtonItem.flexibleSpace(),
//            UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(openSettings))
//        ]
//
//        self.navigationController?.isToolbarHidden = false
        
        
    }
    
    @objc func openMenu() {
        
    }
    
    @objc func openSettings() {
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarItems.count
    }
    
    let rowRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, UITabBarItem> {
        (cell, indexPath, item) in
        
        var contentConfiguration = UIListContentConfiguration.sidebarSubtitleCell()
        contentConfiguration.text = item.title
        contentConfiguration.image = item.image
        
        cell.contentConfiguration = contentConfiguration
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //                        return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: item)
        
        //                        return collectionView.dequeueConfiguredReusableCell(using: expandableRowRegistration, for: indexPath, item: item)
        
        return collectionView.dequeueConfiguredReusableCell(using: rowRegistration, for: indexPath, item: tabBarItems[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didChangeSideBar(index: indexPath.row)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selectedIndex = 0
    }
    
}
#endif
