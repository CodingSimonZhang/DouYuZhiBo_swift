//
//  QFPageTitleView.swift
//  DYZB
//
//  Created by QianFan-MINi on 28/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit
private let kScrollLineHeight : CGFloat = 2
class QFPageTitleView: UIView {
    //Mark: 定义属性
    private var titles : [String]

    //Mark: 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
    //Mark: 自定义构造函数
    init(frame : CGRect ,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI 界面
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QFPageTitleView {
    private func setupUI(){
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的label
        setupTitlesLabels()
        //3.设置底线和滚动滑块
        setupBottomLineAddSrollLine()

    }
    private func setupTitlesLabels(){
        //0.确定label的frame的值
        let labelWidth : CGFloat = frame.width/CGFloat(titles.count)
        let labelHeight : CGFloat = frame.height - kScrollLineHeight
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.创建UIlabel
            let label = UILabel()
            
            //2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = NSTextAlignment.center
            
            //3.设置label的frame
            let labelX : CGFloat = labelWidth * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            //4.将label 添加到scrollView中
            scrollView .addSubview(label)
            titleLabels.append(label)
            
        }
        
        
    }
    private func setupBottomLineAddSrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineHeight :CGFloat = 0.5
        bottomLine.frame = CGRect.init(x: 0, y:frame.height - lineHeight , width: frame.width, height:lineHeight)
        addSubview(bottomLine)
        //2.添加滑动线
        //获取第一个label
        guard let firstLabel = titleLabels.first
            else{
            return
        }
        firstLabel.textColor = UIColor.orange
        //设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x:firstLabel.frame.origin.x, y: frame.height - kScrollLineHeight, width:firstLabel.frame.width, height:kScrollLineHeight)
    }
    
}
