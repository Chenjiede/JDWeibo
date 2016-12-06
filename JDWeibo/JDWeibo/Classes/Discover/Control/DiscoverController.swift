//
//  DiscoverController.swift
//  JDWB
//
//  Created by chen on 16/6/22.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class DiscoverController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否登陆
        if !isLogin { // 还没有登陆
            visitorView?.setupVisitorInfo(imageName: "visitordiscover_image_message" , title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }

    }

}
