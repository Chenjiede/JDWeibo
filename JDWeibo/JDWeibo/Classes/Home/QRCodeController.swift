
//
//  QRCodeController.swift
//  JDWB
//
//  Created by chen on 16/6/30.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

import AVFoundation

class QRCodeController: UIViewController {
    
    /// 容器高度
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    /// 冲击波视图
    @IBOutlet weak var spanView: UIImageView!
    /// 底部tabBar
    @IBOutlet weak var customTabBar: UITabBar!
    /// 冲击波顶部约束
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // MARK: - 懒加载
    /// 输入对象
    private lazy var input : AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
        
        return try? AVCaptureDeviceInput(device: device)
    }()
    
    /// 会话
    private lazy var session : AVCaptureSession = AVCaptureSession()
    
    /// 输出对象
    private lazy var output : AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    /// 预览图层
    private lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置默认的选中
        customTabBar.selectedItem = customTabBar.items?.first
        customTabBar.delegate = self
        
        // 2.开始扫描
        scanQRCode()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
    
    func startAnimation() {
        topConstraint.constant = -heightConstraint.constant
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.0) { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.topConstraint.constant = self.heightConstraint.constant * 0.5
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - 私有方法
    private func scanQRCode() {
        // 1. 判断输入能否添加到会话中
        if !session.canAddInput(input) {
            return
        }
        
        // 2. 判断输出能否添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        
        // 3. 添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
        
        // 4. 设置输出能够解析的数据类型
        // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // 5. 设置监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 6. 添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        
        // 7. 开始扫描
        session.startRunning()
    }

    // MARK: - 视图连线方法
    @IBAction func openPhotos(sender: AnyObject) {
        JDLog(message: "openPhotos")
    }
    @IBAction func closeClick(sender: AnyObject) {
        JDLog(message: "closeClick")
        
        dismiss(animated: true, completion: nil)
    }
}

extension QRCodeController : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // 1. 取消动画
        customTabBar.layer.removeAllAnimations()
        
        // 2. 改变容器视图的高度
        heightConstraint.constant = ((item.tag == 1) ? 150.0 : 300.0)
        
        // 3. 开始动画
        startAnimation()
    }
}

extension QRCodeController : AVCaptureMetadataOutputObjectsDelegate {

    /// 只要扫描到结果就会调用
    private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        JDLog(message: "123")
    }
}
