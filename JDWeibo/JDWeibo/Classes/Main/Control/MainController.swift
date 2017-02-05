//
//  MainController.swift
//  JDWB
//
//  Created by chen on 16/6/22.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
    
    fileprivate lazy var composeButton : UIButton = {
//        () -> UIButton in
        // 1. 创建按钮
        let button = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        
        // 2. 监听点击
        button.addTarget(self, action: #selector(composeClick(_:)), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    @objc func composeClick(_ button : UIButton) {
        JDLog("composeClick")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iOS7以后只要设置tintColor，那么图片和文字就会按照tintColor渲染
//        tabBar.tintColor = UIColor.orangeColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(composeButton)
        
        // 设置button的位置
        let rect = composeButton.frame
        let with = tabBar.bounds.size.width / CGFloat(childViewControllers.count)
        
        composeButton.frame = CGRect(x: 2 * with, y: 0, width: with, height: rect.height)
    }
    
}
