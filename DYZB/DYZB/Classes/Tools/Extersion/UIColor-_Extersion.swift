//
//  UIColor-_Extersion.swift
//  DYZB
//
//  Created by QianFan-MINi on 01/03/2018.
//  Copyright © 2018 QianFan-MINi. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat , b : CGFloat){
     self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
