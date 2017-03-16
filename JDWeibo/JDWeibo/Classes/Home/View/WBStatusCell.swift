//
//  WBStatusCell.swift
//  JDWeibo
//
//  Created by chen on 2016/12/14.
//  Copyright © 2016年 JD. All rights reserved.
//

import UIKit
//import SDWebImage

class WBStatusCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        statusWidthConstraint.constant = UIScreen.main.bounds.width - 30;
    }
    
    /// 模型对象
    var viewModel: StatusViewModel?
        {
        didSet{
            // 1.设置头像
            iconImageView.sd_setImage(with: viewModel?.avatarURL)
            
            // 2.认证图标
//            verifiedImageView.image = viewModel?.verifiedImage
            
            // 3.昵称
            nameLabel.text = viewModel?.status.user?.screen_name ?? ""
            
            // 4.会员图标
            vipImageView.image = viewModel?.mbrankImage
            
            // 5.时间
            timeLabel.text = viewModel?.createdText ?? ""
            
            // 6.来源
            sourceLabel.text  = viewModel?.sourceText ?? ""
            
            // 5.正文
            // contentLabel.text = viewModel?.status.text ?? ""
//            contentLabel.attributedText = XMGKeyboardPackage.createMutableAttrString(viewModel?.status.text ?? "", font: contentLabel.font)
            statusLabel.text = viewModel?.status.text
            
            // 6.转发正文
//            if let temp = viewModel?.status.retweeted_status?.text
//            {
//                forwardLabelWidthCons.constant = UIScreen.mainScreen().bounds.width - 20
//                // forwardLabel.text = temp
//                forwardLabel.attributedText = XMGKeyboardPackage.createMutableAttrString(temp, font: forwardLabel.font)
//            }
            
            // 7.配图
//            pictureCollectionView.viewModel = viewModel
        }
    }
    
}
