//
//  FredKitTabBarController.swift
//  UITabBarSplitView Test App
//
//  Created by Frederik Riedel on 06.01.22.
//

#if os(iOS)
import UIKit

@available(iOS 14.0, *)
open class FredKitTabBarSplitView: UITabBarController {

    let sideBarCollectionView = SidebarCollectionViewController(collectionViewLayout: UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .sidebar)))
    var sideBarContainerView: UIView!
    var sideBarMavigationController: UINavigationController!
    
    let internalTabBarController = UITabBarController()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addChild(internalTabBarController)
        
        sideBarMavigationController = UINavigationController(rootViewController: sideBarCollectionView)
        sideBarMavigationController.navigationBar.prefersLargeTitles = true
        
        self.sideBarContainerView = sideBarMavigationController.view
        
        self.tabBar.addSubview(sideBarContainerView)
        
        
        
        sideBarCollectionView.tabBarItems = tabBar.items!
        sideBarCollectionView.delegate = self
        sideBarContainerView.isHidden = true
        sideBarContainerView.backgroundColor = .secondarySystemBackground
        
        
        self.refreshUI()
        // Do any additional setup after loading the view.
    }
    

    
    
    
    func refreshUI() {
        if self.traitCollection.horizontalSizeClass == .compact {
            
            let bottomSafeArea = self.view.safeAreaInsets.bottom
            if self.traitCollection.verticalSizeClass == .compact {
                self.tabBar.frame = CGRect(x: 0, y: self.view.frame.height - (32 + bottomSafeArea), width: self.view.frame.width, height: 32 + bottomSafeArea)
            } else {
                self.tabBar.frame = CGRect(x: 0, y: self.view.frame.height - (49 + bottomSafeArea), width: self.view.frame.width, height: 49 + bottomSafeArea)
            }
            
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            sideBarContainerView.isHidden = true
            
            self.tabBar.subviews.forEach { view in
                let tabBarButtonClass = NSClassFromString("UITabBarButton")!
                if view.isKind(of: tabBarButtonClass) {
                    view.isHidden = false
                }
            }
            
        } else {
            self.tabBar.frame = CGRect(x: 0, y: 0, width: 300, height: self.view.frame.height)
            
            sideBarContainerView.frame = self.tabBar.bounds
            sideBarContainerView.isHidden = false
            
            
            self.tabBar.subviews.forEach { view in
                let tabBarButtonClass = NSClassFromString("UITabBarButton")!
                if view.isKind(of: tabBarButtonClass) {
                    view.isHidden = true
                }
            }
            
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 0)
        }
    }
    
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.refreshUI()
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            sideBarCollectionView.selectedIndex = index
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@available(iOS 14.0, *)
extension FredKitTabBarSplitView: SidebarCollectionViewControllerDelegate {
    func didChangeSideBar(index: Int) {
        self.selectedIndex = index
    }
}
#endif
