//
//  SWAlert.swift
//  SWAlertView
//
//  Created by Takuya Okamoto on 2015/08/18.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit

public typealias Closure=()->Void

open class TKSwarmAlert {
    
    open var didDissmissAllViews: Closure?

    fileprivate var staticViews: [UIView] = []
    var animationView: FallingAnimationView?
    var blurView: TKSWBackgroundView?

    public init() {
        
    }
    
    open func addNextViews(_ views:[UIView]) {
        self.animationView?.nextViewsList.append(views)
    }
    
    open func addSubStaticView(_ view:UIView) {
        view.tag = -1
        self.staticViews.append(view)
    }
    
    open func show(type:TKSWBackgroundType ,views:[UIView]) {
        let window:UIWindow? = UIApplication.shared.keyWindow
        if window != nil {
            let frame:CGRect = window!.bounds
            blurView = TKSWBackgroundView(frame: frame)
            animationView = FallingAnimationView(frame: frame)
            
            
            let showDuration:TimeInterval = 0.2

            for staticView in staticViews {
                let originalAlpha = staticView.alpha
                staticView.alpha = 0
                animationView?.addSubview(staticView)
                UIView.animate(withDuration: showDuration, animations: {
                    staticView.alpha = originalAlpha
                }) 
            }
            window!.addSubview(blurView!)
            window!.addSubview(animationView!)
            blurView?.show(type: type, duration:showDuration) {
                self.spawn(views)
            }

            animationView?.willDissmissAllViews = {
                let fadeOutDuration:TimeInterval = 0.2
                for v in self.staticViews {
                    UIView.animate(withDuration: fadeOutDuration, animations: {
                        v.alpha = 0
                    }) 
                }
                UIView.animate(withDuration: fadeOutDuration, animations: {
                    self.blurView?.alpha = 0
                }) 
            }
            animationView?.didDissmissAllViews = {
                self.blurView?.removeFromSuperview()
                self.animationView?.removeFromSuperview()
                self.didDissmissAllViews?()
                for staticView in self.staticViews {
                    staticView.alpha = 1
                }
            }
        }
    }
    
    open func spawn(_ views:[UIView]) {
        self.animationView?.spawn(views)
    }
}
