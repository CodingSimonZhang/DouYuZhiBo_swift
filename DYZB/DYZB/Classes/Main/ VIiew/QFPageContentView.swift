//
//  QFPageContentView.swift
//  DYZB
//
//  Created by QianFan-MINi on 28/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit

protocol QFPageContentViewDelegate: class {
    func pageContentView(contentView : QFPageContentView ,progress: CGFloat ,sourceIndex : Int , targetIndex : Int)
}


private let contentCellID  = "contentCellID"

class QFPageContentView: UIView {
    //Mark 定义属性 保存 childVC 和parentVC
    private var childViewControllers : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    weak  var delegate : QFPageContentViewDelegate?
    
    //Mark 懒加载属性
    private lazy var collectionView : UICollectionView = { [weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //2.创建collectionView
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
   //MARK 自定义构造函数
    init(frame: CGRect, childViewControllers:[UIViewController] ,parentViewController : UIViewController?){
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
            parentViewController?.addChildViewController(childVC)
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

extension QFPageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int  = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX{ //左滑
            //1.计算进度
            progress = currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth)
            //2.计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            //3.计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewControllers.count {
                targetIndex = childViewControllers.count - 1
            }
            //4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //1.计算进度、
            progress = 1 - (currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth))
            //2.计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            //3.计算 sourceIndex
            sourceIndex = targetIndex + 1
            

        }
        //3.将progress targetIndex sourceIndex 传给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    
    }
    
}

//Mark 对外暴露的方法
extension QFPageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
    
}



