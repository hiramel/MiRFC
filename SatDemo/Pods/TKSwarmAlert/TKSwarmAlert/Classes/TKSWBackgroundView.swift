//
//  SWBackgroundView.swift
//  blurTest
//
//  Created by Takuya Okamoto on 2015/08/17.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//


import UIKit

public enum TKSWBackgroundType {
    case blur
    case brightBlur
    case transparentBlack(alpha: CGFloat)
}



class TKSWBackgroundView: DynamicBlurView {
    
    
    let transparentBlackView = UIView()
    var brightView: BrightView?

    var blackAlphaForBlur:CGFloat = 0.125
    var blurDuration: TimeInterval = 0.2

    override init(frame:CGRect) {
        super.init(frame:frame)
        self.isHidden = true
        self.blurRadius = 0
        transparentBlackView.frame = frame
        transparentBlackView.backgroundColor = UIColor.black
        transparentBlackView.alpha = 0
        self.addSubview(transparentBlackView)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show(type:TKSWBackgroundType, duration:TimeInterval = 0.2, didEnd:Closure? = nil) {
        if duration != 0.2 {
            self.blurDuration = duration
        }
        
        switch type {
        case .blur:
            showBlur(didEnd)
        case .brightBlur:
            showBrightBlur(didEnd)
        case let .transparentBlack(alpha):
            self.blackAlphaForBlur = alpha
            showTransparentBlack(didEnd)
        }
    }
    
    
    func showTransparentBlack(_ didEnd:Closure? = nil) {
        self.isHidden = false
        UIView.animate(withDuration: blurDuration, animations: {
            self.transparentBlackView.alpha = self.blackAlphaForBlur
        }) 
        Timer.schedule(delay: blurDuration + 0.1) { timer in
            didEnd?()
        }
    }
    
    func showBlur(_ didEnd:Closure? = nil) {
        self.isHidden = false
        UIView.animate(withDuration: blurDuration, animations: {
            self.blurRadius = 6
            self.transparentBlackView.alpha = self.blackAlphaForBlur
        }) 
        Timer.schedule(delay: blurDuration + 0.1) { timer in
            didEnd?()
        }
    }
    
    func showBrightBlur(_ didEnd:Closure? = nil) {
        self.brightView = BrightView(frame: self.frame, center: CGPoint(x: self.center.x, y: self.center.y * 0.6))
        self.insertSubview(brightView!, aboveSubview: transparentBlackView)
        showBlur() {
            self.brightView?.rotateAnimation()
            didEnd?()
        }
    }
}







