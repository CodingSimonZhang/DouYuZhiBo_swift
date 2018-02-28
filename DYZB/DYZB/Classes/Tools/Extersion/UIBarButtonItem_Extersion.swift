//
//  UIBarButtonItem_Extersion.swift
//  DYZB
//
//  Created by QianFan-MINi on 28/02/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    /*
    class func creatItem(imageName: String,highImageName: String,size:CGSize) ->UIBarButtonItem{
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        button.setImage(UIImage.init(named: highImageName), for: UIControlState.highlighted)
        button.frame = CGRect.init(origin: CGPoint.zero, size: size)
        return UIBarButtonItem.init(customView: button)
    }
 */
    //便利构造函数 : 1。convenience 开头 2.在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName: String,highImageName: String = "",size:CGSize = CGSize.zero) {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        if highImageName != "" {
            button.setImage(UIImage.init(named: highImageName), for: UIControlState.highlighted)
        }
        if size == CGSize.zero {
            button.sizeToFit()
        }else{
            button.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
        self.init(customView : button)
    }
}
