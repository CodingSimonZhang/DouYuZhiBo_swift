//
//  QFPageTitleView.swift
//  DYZB
//
//  Created by QianFan-MINi on 28/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit

protocol QFPageTitleViewDelegate : class {
    func pageTitleView(titleView : QFPageTitleView ,slectedIndex index : Int)
}

private let kScrollLineHeight : CGFloat = 2
class QFPageTitleView: UIView {
    //Mark: 定义属性
    private var titles : [String]
    private var currentIndex : Int = 0
    private var tagLabelHeight: CGFloat = 0
    weak var delgate : QFPageTitleViewDelegate?
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
        tagLabelHeight = labelHeight;
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
//            label.frame = CGRect.init(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            //4.将label 添加到scrollView中
            scrollView .addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(labelX)
                make.top.equalTo(labelY)
                make.width.equalTo(labelWidth)
                make.height.equalTo(labelHeight)
            }
            titleLabels.append(label)

            //5.将label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
            
        }
        
        
    }
    private func setupBottomLineAddSrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineHeight :CGFloat = 0.5
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(lineHeight)
        }
        //2.添加滑动线
        //获取第一个label
        guard let firstLabel = titleLabels.first
            else{
            return
        }
        firstLabel.textColor = UIColor.orange
        //设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.snp.makeConstraints { (make) in
            make.left.equalTo(firstLabel)
            make.top.equalTo(tagLabelHeight)
            make.width.equalTo(firstLabel)
            make.height.equalTo(kScrollLineHeight)
        }
    }
    
}
//Mark 监听label的点击
extension QFPageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        //1.获取当前的label
       guard let currentLabel = tapGes.view as? UILabel else{return}
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        //3.切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        //4.保存最新的label的下标值
        currentIndex = currentLabel.tag
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        //获取第一个label
        guard let firstLabel = titleLabels.first
            else{
                return
        }
        UIView.animate(withDuration:0.25) {
            self.scrollLine.snp.updateConstraints({ (make) in
                make.left.equalTo(firstLabel).offset(scrollLineX)
            })
            self.scrollView.superview?.layoutIfNeeded()
        }
       /*
         UIView动画为什么不执行,因为在使用约束添加动画的时候，有个原则就是动画要添加到当前视图的父视图上。所以self.scrollView.layoutIfNeeded()这句话是不对的，应该用scrollView的父视图来调用layoutIfNeeded()。这里改变后就会有动画啦。上面的调整布局也应该改为self.scrollView.superview?.layoutIfNeeded()。
         */
        //6.通知代理
        delgate?.pageTitleView(titleView: self, slectedIndex: currentIndex)
        
    }
    
}



