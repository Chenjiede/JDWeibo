//
//  UIButton+Extension.swift
//  JDWB
//
//  Created by chen on 16/6/23.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init (imageName : String, backgroundImageName : String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        
        setBackgroundImage(UIImage(named: backgroundImageName), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), for: UIControlState.highlighted)
        
        sizeToFit()
    }
}
