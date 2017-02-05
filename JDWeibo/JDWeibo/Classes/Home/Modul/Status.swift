//
//  Status.swift
//  JDWB
//
//  Created by chen on 16/9/29.
//  Copyright © 2016年 chen. All rights reserved.
//

import Foundation

class Status: NSObject {
    
    /// 当前这条微博的发布时间
    var created_at: String?
    
    /// 来源
    var source: String? {
        didSet {
            // 1.处理来源
            // 1.1.安全校验
            guard let temp = source, temp != "" else
            {
                return
            }
            // 1.2.找到开始的位置
            let startIndex = (temp as NSString).range(of: ">").location + 1
            
            // 1.3.找到需要截取的字符串的长度
            let length = (temp as NSString).range(of: "<", options: NSString.CompareOptions.backwards).location - startIndex
            
            // 1.4.截取字符串
            let res = (temp as NSString).substring(with: NSMakeRange(startIndex, length))
            source = "来自 " + res
        }
    }
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 当前微博对应的用户
    var user: User?
    
    ///  存储所有配图字典
    var pic_urls : [[String : AnyObject]]?

    /// 转发的微博
    var retweeted_status : Status?
    
    init(dict : [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dict)
    }
    
    /**
     KVC的setValuesForKeysWithDictionary方法内部会调用下面这个方法
     */
    override func setValue(_ value: Any?, forKey key: String) {
        
        // 1. 判断是否为用户
        if key == "user" {
            user = User(dict: value as! [String : AnyObject])
            return // 注意: 如果自己处理了, 那么就不需要父类处理了, 所以一定要写上return
        }
        
        // 2. 转发的微博
        if key == "retweeted_status" {
            retweeted_status = Status(dict: value as! [String : AnyObject])
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description : String {
        let property = ["created_at", "source", "idstr", "text"]
        let dict = dictionaryWithValues(forKeys: property)
        return "\(dict)"
    }
}
