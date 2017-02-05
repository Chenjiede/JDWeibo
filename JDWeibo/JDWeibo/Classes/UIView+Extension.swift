//
//  UIView+Extension.swift
//  JDWeibo
//
//  Created by chen on 2017/2/1.
//  Copyright © 2017年 JD. All rights reserved.
//

import UIKit

extension UIView {
    /// 裁剪 View 的圆角
    func clipRectCorner(_ direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    public var x : CGFloat {
        set {
            self.frame.origin.x = newValue
//            var tempFrame = self.frame
//            tempFrame.origin.x = newValue
//            self.frame = tempFrame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    public var y : CGFloat {
        set {
            self.frame.origin.y = newValue
//            var tempFrame = self.frame
//            tempFrame.origin.y = newValue
//            self.frame = tempFrame
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    public var width : CGFloat {
        set {
            self.frame.size.width = newValue
        }
        
        get {
            return self.frame.width
        }
    }
    
    public var height : CGFloat {
        set {
            self.frame.size.height = newValue
            
        }
        
        get {
            return self.frame.height
        }
    }
}
