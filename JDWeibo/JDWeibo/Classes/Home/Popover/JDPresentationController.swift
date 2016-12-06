//
//  JDPresentationController.swift
//  JDWB
//
//  Created by chen on 16/6/24.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

let JDPresentationControllerDidDismiss = "JDPresentationControllerDidDismiss"

class JDPresentationController: UIPresentationController {
    
    var presentFrame = CGRect.zero
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = presentFrame
        
        coverButton.addTarget(self, action: #selector(coverBtnClick), for: UIControlEvents.touchUpInside)
        containerView?.insertSubview(coverButton, at: 0)
    }
    
    @objc private func coverBtnClick() {
        
//        NSNotification.Name.UIKeyboardDidHide
        
        // 发出通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: JDPresentationControllerDidDismiss), object: nil)
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    private lazy var coverButton : UIButton = {
        let btn = UIButton(frame: UIScreen.main.bounds)

        return btn
    }()
}
