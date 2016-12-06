//
//  TitleButton.swift
//  JDWB
//
//  Created by chen on 16/6/24.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        adjustsImageWhenHighlighted = false
        
        // 设置标题字体颜色和大小
        setTitleColor(UIColor.darkText, for: UIControlState.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        // 设置默认图标
        setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControlState.normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControlState.selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)!
        
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        let str = title ?? "首页"
        
        super.setTitle(str + "  ", for: UIControlState.normal)
    }
}
