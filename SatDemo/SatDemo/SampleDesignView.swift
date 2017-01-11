//
//  SWDesignView.swift
//  SWAlertView
//
//  Created by Takuya Okamoto on 2015/08/18.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit


enum SampleDesignViewType {
    case bar(icon:UIImage?, text:String)
}


class SampleDesignView: UIView {

    init(type:SampleDesignViewType, frame:CGRect) {
        super.init(frame:frame)
        
        switch type {
        case let .bar(icon, text):
            setupBarDesign(icon: icon, text: text)
        }
    }
    
    func setupBarDesign(icon:UIImage?, text:String) {
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.0
        
//        let margin:CGFloat = 6
        let margin:CGFloat = 270
        
        
        if icon != nil {
            let iconView = UIImageView(image: icon)
            //iconView.contentMode = UIViewContentMode.center
            iconView.contentMode = UIViewContentMode.top
            //iconView.frame = CGRect(x: margin, y: 0, width: self.frame.height, height: self.frame.height)
            iconView.frame = CGRect(x: 80, y: 8, width: self.frame.height, height: self.frame.height)
            self.addSubview(iconView)
        }
        
        var labelLeft = margin
        if icon != nil {
            labelLeft = margin + frame.height + margin
        }
        let label = UILabel()
        label.font = label.font.withSize(15)
        label.frame = CGRect(x: labelLeft + 28, y: 8, width: frame.width - labelLeft - margin, height: frame.height)
        label.numberOfLines = 0
        label.text = text
        self.addSubview(label)

        let label2 = UILabel()
        label2.font = label.font.withSize(15)
        label2.frame = CGRect(x: labelLeft + 108, y: 48, width: frame.width - labelLeft - margin, height: frame.height)
        label2.numberOfLines = 0
        label2.text = "OK"
        self.addSubview(label2)

        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
