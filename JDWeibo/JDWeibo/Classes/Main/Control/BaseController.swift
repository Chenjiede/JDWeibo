//
//  BaseController.swift
//  JDWB
//
//  Created by chen on 16/6/23.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class BaseController: UITableViewController {
    
    var isLogin : Bool = true
    
    var visitorView : Visitor?
    
    override func loadView() {
        // 判断用户是否已经登陆
        isLogin ? super.loadView() : setupVisitorView()
        
    }
   
    // MARK: - 内部私有方法
    /**
     创建访客视图
     */
    private func setupVisitorView() {
        // 1. 创建访客视图
        visitorView = Visitor.visitorView()
        view = visitorView
        
        // 2. 监听按钮点击
        visitorView?.registerButton.addTarget(self, action: #selector(registerClick), for: UIControlEvents.touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(loginClick), for: UIControlEvents.touchUpInside)
        
        // 3. 设置导航栏的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(registerClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.plain, target: self, action: #selector(loginClick))
        
    }
    
    /**
     注册按钮点击监听
     */
    @objc private func registerClick() {
        JDLog(message: "registerClick");
    }
    
    /**
     登陆按钮点击监听
     */
    @objc private func loginClick() {
        JDLog(message: "loginClick");
    }
}
