//
//  User.swift
//  JDWB
//
//  Created by chen on 16/9/29.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class User: NSObject {
    var screen_name : String?
    
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    /// 会员等级 1~6
    var mbrank: Int = -1
    
    /// 认证类型 -1：没有认证，0，个人认证，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1
    
    var access_token : String?
    var uid : String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dict)
    }
    
    override var description : String {
        let property = ["screen_name", "profile_image_url", "verified_type"]
        let dict = dictionaryWithValues(forKeys: property)
        return "\(dict)"
    }
}
