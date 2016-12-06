//
//  UIBarButtonItem+Extension.swift
//  JDWB
//
//  Created by chen on 16/6/23.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName : String, target: AnyObject?, action: Selector, controlEvents: UIControlEvents) {
        let button = UIButton(type: UIButtonType.custom)
        
        button.setImage(UIImage(named: imageName), for: UIControlState.normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        
        button.sizeToFit()
        button.addTarget(target, action: action, for: controlEvents)
        
        self.init(customView : button)
    }
}
