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
        let leftButton = UIButton()
        leftButton.setImage(UIImage.init(named: "头像"), for: UIControlState.normal)
        leftButton.setImage(UIImage.init(named: "头像"), for: UIControlState.selected)
        leftButton.sizeToFit()
//        leftButton.addTarget(self, action: <#T##Selector#>, for: UIControlEvents.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:leftButton)
        
        
        //设置右边的按钮
        
        let historyButton = UIButton()
        historyButton.setImage(UIImage.init(named: "历史记录"), for: UIControlState.normal)
        historyButton.setImage(UIImage.init(named: "历史记录"), for: UIControlState.selected)
        historyButton .sizeToFit()
        let historyItem = UIBarButtonItem.init(customView:historyButton)
        
        let searchButon = UIButton()
        searchButon.setImage(UIImage.init(named: "搜索"), for: UIControlState.normal)
        searchButon.setImage(UIImage.init(named: "搜索"), for: UIControlState.selected)
        searchButon .sizeToFit()
        let searchItem = UIBarButtonItem.init(customView: searchButon)
        
        let qrCodeButon = UIButton()
        qrCodeButon.setImage(UIImage.init(named: "扫一扫"), for: UIControlState.normal)
        qrCodeButon.setImage(UIImage.init(named: "扫一扫"), for: UIControlState.selected)
        qrCodeButon .sizeToFit()
        let qrCodeItem = UIBarButtonItem.init(customView: qrCodeButon)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
        
        
        
    }
    
}
