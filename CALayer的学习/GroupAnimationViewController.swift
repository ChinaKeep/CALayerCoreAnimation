
//
//  GroupAnimationViewController.swift
//  CALayer的学习
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class GroupAnimationViewController: UIViewController,CAAnimationDelegate {

    /*
     动画组是一系列动画的组合，凡是添加到动画组中的动画都受控于动画组，这样一来各类动画公共的行为就可以统一进行控制而不必单独设置，
     而且放到动画组中的各个动画可以并发执行，共同构建出复杂的动画效果。
     
     动画组使用起来并不复杂，首先单独创建单个动画（可以是基础动画也可以是关键帧动画），
     然后将基础动画添加到动画组，最后将动画组添加到图层即可。
     */
    var _layer: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景，这个图片其实是在根图层
        let backgroundImage = UIImage.init(named: "girl.png")
        self.view.backgroundColor = UIColor.init(patternImage: backgroundImage!)
        
        _layer = CALayer()
        _layer?.bounds = CGRect.init(x: 0, y: 0, width: 10, height: 20)
        _layer?.position = CGPoint.init(x: 50, y: 150)
        _layer?.contents = UIImage.init(named: "kunkun.jpg")?.cgImage
        self.view.layer.addSublayer(_layer!)
        //创建动画
        self.groupAnimation()
    }
    
    func groupAnimation() {
        //1,创建动画组
        let animationGroup = CAAnimationGroup.init()
        //2,设置动画组中的动画和主要属性
        let basicAnimation = self.rotationAnimation()
        let keyframeAnimation = self.translationAnimaton()
        animationGroup.animations = [basicAnimation,keyframeAnimation]
        
        animationGroup.delegate = self as CAAnimationDelegate
        animationGroup.duration = 10.0
        animationGroup.beginTime = CACurrentMediaTime() + 1;
        //3.给图层添加动画
        _layer?.add(animationGroup, forKey: nil)
        
    }
    //MARK:-- 基础旋转动画 --
    func rotationAnimation() -> CABasicAnimation {
        let basicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        
        basicAnimation.toValue = NSNumber.init(value: Float.pi/2*3)
        
        basicAnimation.autoreverses = true
        basicAnimation.repeatCount = HUGE
        basicAnimation.isRemovedOnCompletion = false
        let toValue = Float.pi/2*3
        basicAnimation.setValue(NSNumber.init(value: toValue), forKey: "KCBasicAnimationProperty_ToValue")
        return basicAnimation;
    }
    
    //MARK:-- 关键帧动画 --
    func translationAnimaton() -> CAKeyframeAnimation {
        let keyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
        
        let endPoint = CGPoint.init(x: 155, y: 400)
        let path = CGMutablePath()
        path.move(to: CGPoint.init(x: (_layer?.position.x)!, y: (_layer?.position.y)!))
        path.addCurve(to: CGPoint.init(x:160, y: 280), control1: CGPoint.init(x: -30, y: 300), control2: CGPoint.init(x: endPoint.x, y: endPoint.y))
        keyframeAnimation.path = path
        
        keyframeAnimation.setValue(NSValue.init(cgPoint: endPoint), forKey: "KCKeyframeAnimationProperty_EndPosition")
        return keyframeAnimation
    }
    
    //MARK:-- CAAnimationDelegate --
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        let animationGroup = anim as! CAAnimationGroup
        let basicAnimation = animationGroup.animations?.first
        let keyframeAnimation = animationGroup.animations![1]
        
        let toValue = basicAnimation?.value(forKey: "KCBasicAnimationProperty_ToValue")
        let endPoint = keyframeAnimation.value(forKey: "KCKeyframeAnimationProperty_EndPosition")
        
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        //设置动画最终状态
        _layer?.position = endPoint as! CGPoint
        _layer?.transform = CATransform3DMakeRotation(toValue as! CGFloat, 0, 0, 1)
        
        CATransaction.commit()
        
    }
}
