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
    fileprivate lazy var animManager : AnimationManager = {
        let anim = AnimationManager()
        anim.presentFrame = CGRect(x: 100, y: 65, width: 200, height: 300)
        return anim
    }()
    
    fileprivate lazy var titleButton : TitleButton = {
        let titleBtn = TitleButton()
        titleBtn.setTitle("极客江南", for: UIControlState.normal)
        titleBtn.sizeToFit()
        
        titleBtn.addTarget(self, action: #selector(titleButtonClick(button:)), for: UIControlEvents.touchUpInside)
        return titleBtn
    }()
    
    var dataArray = [StatusViewModel]()
    
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否登陆
        if !isLogin { // 还没有登陆
            visitorView?.setupVisitorInfo(nil , title: "关注一些人，回这里看看有什么惊喜")
            
            return
        }
        
        // 注册cell
//        tableView.register(WBStatusCell.classForCoder(), forCellReuseIdentifier: HomeStatusCellID)
        tableView.register(UINib.init(nibName: "WBStatusCell", bundle: nil), forCellReuseIdentifier: HomeStatusCellID)
        tableView.rowHeight = 200
        
        // 初始化导航栏
        setupNavItem()
        
        // 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(popoverViewDidDismiss), name:NSNotification.Name(rawValue: JDPresentationControllerDidDismiss), object: nil)
        
        // 获取用户数据数据
        requestUeerData()
        
        // 获取微博数据
        requestStatusData()
    }
    
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - 内部初始化私有方法
    /// 获取微博数据
    private func requestStatusData() {
        
        assert(UserAccount.loadUserAccount() != nil, "必须先授权")
        let params = ["access_token" : UserAccount.userAccount?.access_token]
        
        NetworTools.shareInstance.get("2/statuses/home_timeline.json", parameters: params, progress: nil, success: {(task, data) -> Void in
            // 转换成模型
            guard let array = (data as! [String :AnyObject])["statuses"], let dicts = array as? [[String :AnyObject]] else {
                
                JDLog("数据转换模型失败")
                return
            }
            
            for dict in dicts {
                let status = Status.init(dict: dict)
                self.dataArray.append(StatusViewModel(status: status))
            }
            
            self.tableView.reloadData()
//            JDLog(message: data)
        }, failure: {(task, error) -> Void in
            JDLog(error)
        })
    }
    
    /// 获取用户数据数据
    private func requestUeerData() {
        // 获取沙盒的数据
        let userAccount = UserAccount.loadUserAccount()
        
        if let userAccount = userAccount {
            
            self.titleButton.setTitle(userAccount.screen_name, for: .normal)
            return
        }
        
        // 参数
        var params = [String : String]()
        params["access_token"] = "2.00TCMKEDFja4jB0c8bb325adO2xLmC"
        params["uid"] = "2809933401"
        
        NetworTools.shareInstance.get("2/users/show.json", parameters: params, progress: nil, success:{(task, data) -> Void in
//            JDLog(message: data)
            let dict = data as? [String : AnyObject]
            if let dict = dict {
                let user = UserAccount.init(dict: dict)
                
                self.titleButton.setTitle(user.screen_name ?? "首页", for: .normal)
                
                // 保存数据
                user.save()
            }
            
        }, failure: {(task, error) -> Void in
            JDLog(error)
        })
        
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
        JDLog("leftBarButtonClick")
    }
    
    @objc private func rightBarButtonClick() {
//        JDLog("rightBarButtonClick")
        let QRVC = UIStoryboard.init(name: "QRCode", bundle: nil).instantiateInitialViewController()!
        
        // 跳转
        present(QRVC, animated: true, completion: nil)
    }
}

extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeStatusCellID, for: indexPath) as! WBStatusCell
        cell.viewModel = self.dataArray[indexPath.row]
        
        return cell
    }
}
