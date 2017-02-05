//
//  ProfileController.swift
//  JDWB
//
//  Created by chen on 16/6/22.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class ProfileController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否登陆
        if !isLogin { // 还没有登陆
            visitorView?.setupVisitorInfo("visitordiscover_image_profile" , title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        }

    }

}
