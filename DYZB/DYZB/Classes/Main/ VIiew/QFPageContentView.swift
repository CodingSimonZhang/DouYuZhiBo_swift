//
//  QFPageContentView.swift
//  DYZB
//
//  Created by QianFan-MINi on 28/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit

private let contentCellID  = "contentCellID"

class QFPageContentView: UIView {
    //Mark 定义属性 保存 childVC 和parentVC
    private var childViewControllers : [UIViewController]
    private var parentViewController : UIViewController
    
    //Mark 懒加载属性
    
    private lazy var collectionView : UICollectionView = {
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //2.创建collectionView
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
   //MARK 自定义构造函数
    init(frame: CGRect, childViewControllers:[UIViewController] ,parentViewController : UIViewController){
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super .init(frame: frame)
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//Mark: 设置UI 界面
extension QFPageContentView {
    private func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childVC in childViewControllers {
            parentViewController.addChildViewController(childVC)
        }
        //2.添加UICollerctionView 用于cell中存储控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

extension QFPageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:contentCellID , for: indexPath)
      //2.给cell添加内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childViewControllers[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView .addSubview(childVC.view)
        return cell
    }
    
}


