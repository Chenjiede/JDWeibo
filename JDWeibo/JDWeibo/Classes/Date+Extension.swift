//
//  Date+Extension.swift
//  JDWeibo
//
//  Created by chen on 2016/12/14.
//  Copyright © 2016年 JD. All rights reserved.
//

import Foundation

extension Date {
    /// 根据制定字符串转换NSDate
    static func date(with str : String) -> Date? {
        // 1.1创建时间格式化对象
        let dateFormat = DateFormatter.init()
        
        // 1.2初始化时间格式化对象  "Tue May 31 17:46:55 +0800 2011"
        dateFormat.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        dateFormat.locale = Locale.init(identifier: "en")
        
        // 1.3将发布微博的时间字符串转换为Date
        return dateFormat.date(from: str)
    }
    
    /// 返回格式化之后的时间字符串
    var desc : String {
        // 1创建时间格式化对象
        let dateFormat = DateFormatter.init()
        dateFormat.locale = Locale.init(identifier: "en")
        
        // 日历
        let calendar = Calendar.current
        
        // 判断是否是今天
        if calendar.isDateInToday(self) {
            // 获取时间差
            let timeInterval = Int(Date.init().timeIntervalSince(self))
            
            if timeInterval < 60 {
                return ""
            } else if timeInterval < 60 * 60 {
                return "\(timeInterval / 60)分钟以前"
            } else if timeInterval < 60 * 60 * 24 {
                return "\(timeInterval / 60 / 60)小时前"
            }
            
        }
        
        // 昨天
        var formatterStr = "HH:mm"
        
        let comps = calendar.dateComponents([Calendar.Component.year], from: Date(), to: self)
        
        if calendar.isDateInYesterday(self)
        {
            formatterStr = "昨天 " + formatterStr
        }else if comps.year! < 1
        {
            // 一年以内
            formatterStr = "MM-dd " + formatterStr
        }else
        {
            // 更早时间
            formatterStr = "yyyy-MM-dd " + formatterStr
        }
        
        dateFormat.dateFormat = formatterStr
        return dateFormat.string(from: self)
    }
}
