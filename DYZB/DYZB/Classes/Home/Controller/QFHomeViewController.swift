//
//  HomeViewController.swift
//  DYZB
//
//  Created by QianFan-MINi on 27/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit


class QFHomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}
extension QFHomeViewController {
    private func setupUI(){
        //设置导航栏
        setupNavigationBar()
    }
    private func setupNavigationBar(){
        //设置左侧的item
//        let leftButton = UIButton()
//        leftButton.setImage(UIImage.init(named: "头像"), for: UIControlState.normal)
//        leftButton.sizeToFit()
//        leftButton.addTarget(self, action: <#T##Selector#>, for: UIControlEvents.touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:leftButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "头像")
        
        //设置右边的按钮
        let size = CGSize.init(width: 30, height: 30)
//        let historyItem = UIBarButtonItem.creatItem(imageName: "历史记录", highImageName: "历史记录", size: size)
//        let searchItem = UIBarButtonItem.creatItem(imageName: "搜索", highImageName: "搜索", size: size)
//        let qrCodeItem = UIBarButtonItem.creatItem(imageName: "扫一扫", highImageName: "扫一扫", size: size)
        let historyItem = UIBarButtonItem.init(imageName: "历史记录", highImageName: "", size: size)
        let searchItem = UIBarButtonItem.init(imageName: "搜索", highImageName: "", size: size)
        let qrCodeItem = UIBarButtonItem.init(imageName: "扫一扫", highImageName: "", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
        
        
        
    }
    
}
