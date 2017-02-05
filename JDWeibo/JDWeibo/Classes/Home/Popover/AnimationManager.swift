//
//  AnimationManager.swift
//  JDWB
//
//  Created by chen on 16/6/24.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class AnimationManager: NSObject, UIViewControllerTransitioningDelegate {
    // 判断标志位
    var present = false
    
    var presentFrame = CGRect.zero
    
    /**
     负责返回设置弹出视图的相关属性的方法
     */
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = JDPresentationController(presentedViewController: presented, presenting: presenting)
        pc.presentFrame = presentFrame
        
        return pc
    }
    
    /**
     返回展示视图处理的对象
     */
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        present = true
        return self
    }
    
    /**
     返回销毁视图处理的对象
     */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        present = false
        return self
    }
}

extension AnimationManager : UIViewControllerAnimatedTransitioning {
    
    /**
     计算动画时长的方法
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.75
    }
    
    /**
     转场动画处理
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if present { // 展示视图
            
            showPopoverView(transitionContext)
        } else { // 销毁视图
            dismissPopoverView(transitionContext)
        }
        
    }
    
    fileprivate func showPopoverView(_ transitionContext: UIViewControllerContextTransitioning) {
        // 获取要跳转的View
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        transitionContext.containerView.addSubview(toView)
        // 设置锚点
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        
        // 开始执行动画
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            toView.transform = CGAffineTransform.identity
            
            }) { (_) -> Void in
                // 一定要告诉系统动画执行完毕
                transitionContext.completeTransition(true)
        }
    }
    
    fileprivate func dismissPopoverView(_ transitionContext: UIViewControllerContextTransitioning) {
        // 获取要跳转的View
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        // 设置锚点
        fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        
        // 开始执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
            }) { (_) -> Void in
                // 一定要告诉系统动画执行完毕
                transitionContext.completeTransition(true)
        }
    }
    
}
