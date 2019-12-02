//
//  ChangeAnimationLocationVC.swift
//  CALayer的学习
//
//  Created by apple on 2019/11/29.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class ChangeAnimationLocationVC: UIViewController,CALayerDelegate,CAAnimationDelegate {
     var _changeLayer : CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backgroundImage = UIImage.init(named: "girl.png")
        self.view.backgroundColor = UIColor.init(patternImage: backgroundImage!)

        _changeLayer = CALayer()
        _changeLayer?.bounds = CGRect.init(x: 0, y: 0, width: 10, height: 20)
        _changeLayer?.position = CGPoint.init(x: 50, y: 150)
        _changeLayer?.contents = UIImage.init(named: "kunkun.jpg")?.cgImage
//        _changeLayer!.delegate = self
        self.view.layer.addSublayer(_changeLayer!)
    }
    

    func display(_ layer: CALayer) {
        print("CALayerDelegate")
    }
     func animationDidStart(_ anim: CAAnimation) {

//        print("animation:",anim,"\r", "start->_changeLayer.frame:",NSCoder.string(for: _changeLayer!.frame));
//        print("location:",_changeLayer?.animation(forKey: "KCBasicAnimation_Translation") as Any)//通过前面的设置的key获得动画
    }
    /*
     关闭隐式动画需要用到动画事务CATransaction 在事务内将隐式动画关闭
     
     */
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        print("animation:",anim,"\r","stop->_changeLayer.frame",NSCoder.string(for:(_changeLayer?.frame)!))
        
        //1.开启事务
        CATransaction.begin()
        //2.禁用隐式动画
        CATransaction.setDisableActions(true)
        _changeLayer!.position = anim.value(forKey: "KCBasicAnimationLocation") as! CGPoint
        //3.提交事务
        CATransaction.commit()
    }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch:UITouch = (touches as NSSet).anyObject() as! UITouch
            let location = touch.location(in: self.view)
            
            //判断是否已经创建过动画，如果已将创建则不再创建动画
            let animation = _changeLayer?.animation(forKey: "KCBasicAnimation_Translation")
            let rotationAnimation = _changeLayer?.animation(forKey: "KCBasicAnimation_Rotation")
            let animations = _changeLayer?.animationKeys()
            #if DEBUG
            print("移动动画:",animation as Any,"旋转动画：",rotationAnimation as Any)
            print("动画数组",animations as Any)
            #else
            print("animation:",animation as Any)
            #endif
            
            if (animation != nil) {
                if(_changeLayer?.speed == 0){
                    self.animationResume()
                }else{
                    self.animationPause()
                }
            }else{
                self.translationAnimation(point: location)
                
                self.rotationAnimation()
            }
        }
    /*
     
     核心动画的运行有一个媒体时间的概念，假设将一个旋转动画设置旋转一周用时60秒的话
     那当动画旋转90度后媒体时间就是15秒，如果此时要将动画暂停只需要让媒体时间偏移设置为15秒即可
     并把动画运行速度设置为0使其停止运动。类似的，如果又过了60秒后需要回复动画（此时媒体时间75秒）
     这时只要将动画开始时间设置为当前媒体时间75秒减去暂停时的时间（也就是之前定格动画时的偏移量）15秒
     （开始时间= 75-15 = 60秒）那么动画就会重新计算60秒后的状态再开始运行，此时同时将偏移量重新设置为0
     并且把运行速度设置1.这个过程中真正起到暂停动画和恢复动画的其实是动画速度的调整。媒体时间偏移量以及恢复
     时的开始时间设置主要是为了让动画更加连贯
     
     注意：动画暂停针对的是图层而不是图层中的某个动画
     要做无限循环动画，动画的removedOnCompletion属性必须设置为NO，否则运行一次动画就会销毁
     */
    //MARK:-  动画暂停
    func animationPause() {
        //取得指定图层动画的媒体时间，后面参数用于指定子图层。这里不需要
        let interval = _changeLayer?.convertTime(CACurrentMediaTime(), from: nil)
        //设置偏移量。保证暂停时停留在旋转的位置
        _changeLayer?.timeOffset = interval!
        //速度为0 暂停动画
        _changeLayer?.speed = 0
    }
    //MARK:- 动画恢复
    func animationResume()  {
        //获得暂停时间
        let beginTime = CACurrentMediaTime() - (_changeLayer?.timeOffset)!
        //设置偏移量
        _changeLayer?.timeOffset = 0
        //设置开始时间
        _changeLayer?.beginTime = beginTime
        //设置动画速 开始运动
        _changeLayer?.speed = 1.0
    }
//    MARK:- --- 移动动画 ---
        func translationAnimation(point: CGPoint) {
            //创建动画并制定动画属性
            let basicAnimation = CABasicAnimation.init(keyPath: "position")
            //2.设置动画属性初始值和结束值
//            basicAnimation.fromValue = NSNumber.init(value: 50)//可以不设定，默认为图层初始状态
            basicAnimation.toValue = NSValue.init(cgPoint: point)
            //设置其他动画属性
            basicAnimation.delegate = self
            basicAnimation.duration =  5.0//动画时间5秒
            
            basicAnimation.isRemovedOnCompletion = false //运行结束是否移除动画
            
            //存储当前位置在动画结束后使用
            /*
             通过给动画设置一个代理去监听动画的开始和结束事件
             在动画开始前给动画添加一个自定义属性“KCBasicAnimationLocation” 存储动画终点位置
             然后在动画结束后设置动画的位置为终点位置
             
             */
            basicAnimation.setValue(NSValue.init(cgPoint: point), forKey: "KCBasicAnimationLocation")
            //3.添加动画到图层，注意key相当于给动画起个名字，以后获取该动画可以使用此名称获取
            _changeLayer?.add(basicAnimation, forKey: "KCBasicAnimation_Translation")
        }
    /*
     运行后会发现，动画完成后悔重新从起点运动到终点
     这个问题就是因为，对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性
     会产生动画效果，解决这个问题的办法有两种：
     1、关闭隐士动画、
     2、设置动画图层为根图层
     ）
     */
    
    
    //MARK: -- 旋转动画
    func rotationAnimation()  {
        //1.创建动画并制定动画属性 //围绕z轴旋转
        let basisAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        //2.设置动画属性初始值、结束值
        basisAnimation.fromValue = NSNumber.init(value: Double.pi/2)
        basisAnimation.toValue = NSNumber.init(value: Double.pi/2*3)
        //3.设置其他动画属性
        basisAnimation.duration = 6.0
        basisAnimation.autoreverses = true//旋转后再旋转到原来的位置
        basisAnimation.repeatCount = HUGE
        basisAnimation.isRemovedOnCompletion = false
        //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称
        _changeLayer?.add(basisAnimation, forKey: "KCBasicAnimation_Rotation")
    }
    /*
     上面代码结合两种动画操作，需要注意的是只给移动动画设置了代理方法
     在旋转动画中没有设置代理，否则代理会执行两边。由于旋转动画会无限执行
     并且两个动画的执行时间没有必然的关系，这样一来移动停止后可能还在旋转，
     为了让移动动画停止后旋转动画就停止
     就需要使用到动画的暂停和恢复方法
    
     */
    
    
}
/*
 前面说过图层动画的本质就是将图层内部的内容转化为位图经硬件操作形成一种动画效果
 其实图层本身没有任何变化，上面的动画中图层并没有因为动画效果而改变它的位置
 对于缩放动画其实大小也是不会改变的，所以动画完成后图层还是在原来显示的位置没有任何变化
 如果这个图层在一个UIView中你会发现UIView在移动的过程中，你要触发UIView的点击事件也只能
 点击原来的位置（即使它已经运动到了别的位置）因为它的位置从来没有变过。当然解决这个问题的办法表较多
 我们不妨 在动画完成之后重新设置它的位置
 
 */
