//
//  HomeController.swift
//  JDWB
//
//  Created by chen on 16/6/22.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class HomeController: BaseController {

    // MARK: - 懒加载
    private lazy var animManager : AnimationManager = {
        let anim = AnimationManager()
        anim.presentFrame = CGRect(x: 100, y: 65, width: 200, height: 300)
        return anim
    }()
    
    private lazy var titleButton : TitleButton = {
        let titleBtn = TitleButton()
        titleBtn.setTitle("极客江南", for: UIControlState.normal)
        titleBtn.sizeToFit()
        
        titleBtn.addTarget(self, action: #selector(titleButtonClick(button:)), for: UIControlEvents.touchUpInside)
        return titleBtn
    }()
    
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否登陆
        if !isLogin { // 还没有登陆
            visitorView?.setupVisitorInfo(imageName: nil , title: "关注一些人，回这里看看有什么惊喜")
            
            return
        }
        
        // 初始化导航栏
        setupNavItem()
        
        // 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(popoverViewDidDismiss), name:NSNotification.Name(rawValue: JDPresentationControllerDidDismiss), object: nil)
        
        // 获取数据
        requestData()
    }
    
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - 内部初始化私有方法
    /**
    获取数据
    {
    "access_token" = "2.00TCMKEDFja4jB0c8bb325adO2xLmC";
    uid = 2809933401;
    }

    */
    private func requestData() {
        // 参数
        var params = [String : String]()
        params["access_token"] = "2.00TCMKEDFja4jB0c8bb325adO2xLmC"
        params["uid"] = "2809933401"
        
        HttpTools.sessionGET(urlStr: "https://api.weibo.com/2/users/show.json?access_token=2.00TCMKEDFja4jB0c8bb325adO2xLmC&uid=2809933401", success: { (data) -> Void in
            let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
            print(str)
            }) { (error) -> Void in
            print(error)
        }
//        NetworTools.shareInstance .GET("2/users/show.json", parameters: params, success: { (NSURLSessionDataTask, data) -> Void in
//            
//            }) { (NSURLSessionDataTask?, error) -> Void in
//                
//        }
    }
    
    private func setupNavItem() {
        // 设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftBarButtonClick), controlEvents: UIControlEvents.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightBarButtonClick), controlEvents: UIControlEvents.touchUpInside)
        
        // 设置标题按钮
        navigationItem.titleView = titleButton

    }

    // MARK: - 内部监听方法
    @objc private func popoverViewDidDismiss() {
        // 改变按钮的状态
        titleButton.isSelected = !titleButton.isSelected
    }
    
    @objc private func titleButtonClick(button : TitleButton) {
        // 改变按钮的状态
        button.isSelected = !button.isSelected
        
        // 弹出菜单栏
        let popover = UIStoryboard(name: "Popover", bundle: nil).instantiateInitialViewController()!
        
        popover.transitioningDelegate = animManager
        popover.modalPresentationStyle = UIModalPresentationStyle.custom
        
        present(popover, animated: true, completion: nil)
    }
    
    @objc private func leftBarButtonClick() {
        JDLog(message: "leftBarButtonClick")
    }
    
    @objc private func rightBarButtonClick() {
//        JDLog("rightBarButtonClick")
        let QRVC = UIStoryboard.init(name: "QRCode", bundle: nil).instantiateInitialViewController()!
        
        // 跳转
        present(QRVC, animated: true, completion: nil)
    }
}
