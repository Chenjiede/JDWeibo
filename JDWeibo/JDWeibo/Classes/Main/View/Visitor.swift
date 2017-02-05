//
//  Visitor.swift
//  JDWB
//
//  Created by chen on 16/6/23.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class Visitor: UIView {
    
    /**
     转盘视图
     */
    @IBOutlet weak var rotationImageView: UIImageView!
    /**
     注册按钮
     */
    @IBOutlet weak var registerButton: UIButton!
    /**
     登陆按钮
     */
    @IBOutlet weak var loginButton: UIButton!
    /**
     图标
     */
    @IBOutlet weak var iconImageView: UIImageView!
    /**
     文本标签
     */
    @IBOutlet weak var titleLabel: UILabel!
    
    /**
     快速创建visitor
     */
    class func visitorView() -> Visitor{
        
        return Bundle.main.loadNibNamed("Visitor", owner: nil, options: nil)!.first as! Visitor
    }
    
    func setupVisitorInfo(_ imageName : String? , title : String) {
        // 设置标题
        titleLabel.text = title
        
        // 判断子控制器的类型
        guard let name = imageName else {
            // 首页
            
            // 启动转盘动画
            startAnimation()
            
            return
        }
        
        rotationImageView.isHidden = true
        
        // 设置图标 
        iconImageView.image = UIImage(named: name)
        
    }
    
    fileprivate func startAnimation() {
        // 创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        // 设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        // 注意: 默认情况下只要视图消失, 系统就会自动移除动画
        // 只要设置removedOnCompletion为false, 系统就不会移除动画
        anim.isRemovedOnCompletion = false
        
        // 添加动画
        rotationImageView.layer.add(anim, forKey: nil)
    }
}
