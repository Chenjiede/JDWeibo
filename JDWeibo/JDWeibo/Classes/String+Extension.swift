//
//  String+Extension.swift
//  JDWeibo
//
//  Created by chen on 2016/12/12.
//  Copyright © 2016年 JD. All rights reserved.
//

import Foundation

extension String {
    
    func docDir() -> String {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        return (filePath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }
    
    func cacheDir() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        return (cachePath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }
    
    func tmpDir() -> String {
        let tmpPath = NSTemporaryDirectory()
        
        return (tmpPath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }
}
