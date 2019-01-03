//
//  HomeViewController.swift
//  DYZB
//
//  Created by QianFan-MINi on 27/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit

private let kTitleViewHeight : CGFloat = 40

class QFHomeViewController: UIViewController {
    //Mark 懒加载
    private lazy var pageTitleView : QFPageTitleView = { [weak self] in
        let titleFrame = CGRect.init(x: 0, y: kStatusBarHeight+kNavigationBarHeight, width:kScreenWidth, height:kTitleViewHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = QFPageTitleView.init(frame:titleFrame , titles:titles)
        titleView.delgate = self
        return titleView
    }()//闭包
    
    
    
    private lazy var pageContentView : QFPageContentView = {[weak self] in
        //1.确定内容的Frame
        let contentViewHeight = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTitleViewHeight
        let contViewFrame = CGRect.init(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTitleViewHeight, width: kScreenWidth, height: contentViewHeight)
        //2.确定所有子控制器
        var childViewControllers = [UIViewController]()
        for i in 0..<4{
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)) , b: CGFloat(arc4random_uniform(255)))
            childViewControllers .append(viewController)
            
        }
        
        let contentView = QFPageContentView.init(frame: contViewFrame, childViewControllers: childViewControllers, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    //Mark 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
}
//设置UI 界面
extension QFHomeViewController {
    private func setupUI(){
        view.backgroundColor = UIColor.white
        
        //0.不需要调整scrollView 内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加TitleView
        view.addSubview(pageTitleView)
        //添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
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
//Mark :1.遵守pageTitleView的delegate 协议
extension QFHomeViewController : QFPageTitleViewDelegate{
    func pageTitleView(titleView: QFPageTitleView, slectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}

//Mark :2.遵守pageContentView的delegate 协议
extension QFHomeViewController : QFPageContentViewDelegate {
    func pageContentView(contentView: QFPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
    }
}


