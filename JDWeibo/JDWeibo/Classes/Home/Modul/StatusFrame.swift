//
//  StatusFrame.swift
//  JDWB
//
//  Created by chen on 16/9/29.
//  Copyright © 2016年 chen. All rights reserved.
//

/*
Swift中一个类可以有父类也可以没有父类
如果一个类没有父类, 那么这个类更加轻量级, 那么他们性能会更优于有父类的

有父类和没有父类有什么区别?
1.如果想使用KVC, 那么必须继承于NSObject
2.如果想实现description属性, 那么如果没有父类必须遵守CustomStringConvertible, 如果有父类可以直接重写属性即可
*/

import UIKit

class StatusFrame: NSObject {
    
    var status : Status
    
    init(status : Status) {
        
        self.status = status
        
        /*
        想要性能比较好, 就将固定不变的数据放在init方法中处理, 如果代码较多, 那么就为每个逻辑创建一个方法, 将对应的代码放到方法中去
        如果不在乎性能, 可以直接通过get方法处理数据
        */
        
        // 2.处理图片
        guard let urls = (status.retweeted_status != nil) ? status.retweeted_status?.pic_urls : status.pic_urls else {
            
            return
        }
        
//        thumbnail_pics = [NSURL]()
//        bmiddle_pics = [NSURL]()
//        
//        for dict in urls {
//            // 1.处理缩略图
//            var urlStr = dict["thumbnail_pic"] as? String
//            let url = NSURL(string: urlStr ?? "")!
//            thumbnail_pics.append(url)
//            
//            
//        }
        
    }
    
    
}
