//
//  QFTabBarController.swift
//  DYZB
//
//  Created by QianFan-MINi on 27/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit

class QFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = QFHomeViewController()
        setupChildVC(childVC: homeVC, imageName:"home_tabBar_normal", selectImageName: "home_tabBar_selected", title: "首页")
        let liveVC = QFLiveViewController()
        setupChildVC(childVC: liveVC, imageName:"live_tabBar_normal", selectImageName: "live_tabBar_sekected", title: "直播")
        let followVC = QFFollowViewController()
        setupChildVC(childVC: followVC, imageName:"follow_tabBar_normal", selectImageName: "follow_tabBar_selected", title: "关注")
        let profileVC = QFProfileViewController()
        setupChildVC(childVC: profileVC, imageName:"profile_tabBar_normal", selectImageName: "profile_tabBar_selected", title: "我的")
        
    }
    
    private func setupChildVC(childVC:UIViewController , imageName:String, selectImageName:String,title:String){
        childVC.title = title;
        childVC.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.gray], for:UIControlState.normal)
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], for: UIControlState.selected)
        let rootNavigation = QFNavigationController()
        rootNavigation.addChildViewController(childVC)
        addChildViewController(rootNavigation)
    }
}
