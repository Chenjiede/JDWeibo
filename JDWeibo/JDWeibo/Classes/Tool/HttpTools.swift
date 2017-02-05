//
//  HttpTools.swift
//  JDWB
//
//  Created by chen on 16/7/6.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit
import Foundation

class HttpTools: NSObject {
    
    class func sessionGET(_ urlStr : String, success: @escaping (Data) ->Void, failure: @escaping (Error) ->Void) {
        
        let session = URLSession.shared
        
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            
            if (error != nil) {
                JDLog("error")
                failure(error!)
            } else {
                guard let dataStr = data else { return }
                success(dataStr)
            }
            
        }
        
        task.resume()
    }
    
}
