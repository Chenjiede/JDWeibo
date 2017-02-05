//
//  UserAccount.swift
//  JDWB
//
//  Created by chen on 16/7/7.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {

    /// 令牌
    var access_token: String? {
        get {
            return "2.00TCMKEDFja4jB0c8bb325adO2xLmC"
        }
    }
    
    /// 从授权那一刻开始, 多少秒之后过期时间
    var expires_in: Int = 0 {
        didSet {
            expires_Date = Date(timeIntervalSinceNow: TimeInterval(expires_in))
        }
    }
    
    /// 真正过期时间
    var expires_Date: Date?
    
    /// 用户ID
    var uid: String? {
        get {
            return "2809933401"
        }
    }
    
    ///  用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    /// 用户昵称
    var screen_name: String?
    
    /// 静态对象
    static var userAccount : UserAccount?
    /// 文件路径
    static let filePath = "userAccount.plist".docDir()
    
    init(dict: [String : AnyObject]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    // 当KVC发现没有对应的key时就会调用
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        // 将模型转换为字典
        let property = ["access_token", "expires_in", "uid", "expires_Date"]
        let dict = dictionaryWithValues(forKeys: property)
        
        return "\(dict)"
    }
    
    // MARK: - 外部控制方法
    /// 保存用户数据
    func save() {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
        
        UserAccount.userAccount = self
    }
    
    /// 读取沙盒的用户数据
    class func loadUserAccount() -> UserAccount? {
        if userAccount != nil {
            return userAccount
        }
        
        // 从沙盒中加载
        userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UserAccount
        
        return userAccount
    }
    
    class func isLogin() -> Bool {
        
        return loadUserAccount() != nil
    }
    
    // MARK: - NSCoding
    open func encode(with aCoder: NSCoder) {
//        aCoder.encode(access_token, forKey: "access_token")
//        aCoder.encode(expires_in, forKey: "expires_in")
//        aCoder.encode(expires_Date, forKey: "expires_Date")
//        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
//        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
//        self.expires_in = aDecoder.decodeInteger(forKey: "expires_in") as Int
//        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
//        self.expires_Date = aDecoder.decodeObject(forKey: "expires_Date") as? NSDate
        self.avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
}
