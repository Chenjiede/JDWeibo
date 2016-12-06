//
//  MessageController.swift
//  JDWB
//
//  Created by chen on 16/6/22.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class MessageController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否登陆
        if !isLogin { // 还没有登陆
            visitorView?.setupVisitorInfo(imageName: "visitordiscover_image_message" , title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }
    }

}
