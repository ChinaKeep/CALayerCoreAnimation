

//
//  UIVIewAnimationVC.swift
//  CALayer的学习
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class UIVIewAnimationVC: UIViewController {
    /*
     在核心动画开篇也给大家说过，其实UIView本身对于基本动画和关键帧动画、转场动画都有相应的封装，
     在对动画细节没有特殊要求的情况下使用起来也要简单的多。
     可以说在日常开发中90%以上的情况使用UIView的动画封装方法都可以搞定
     */
    var _imageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage.init(named: "girl.png")
        self.view.backgroundColor = UIColor.init(patternImage: backgroundImage!)
        
        _imageView = UIImageView.init(image: UIImage.init(named: "kunkun.jpg"))
        _imageView?.center = CGPoint.init(x: 50, y: 150)
        _imageView?.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        self.view.addSubview(_imageView!)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()
        let location = (touch as! UITouch).location(in: self.view)
        
        //方法1：block方式
        /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
         duration:执行时间
         delay:延迟时间
         options:动画设置，例如自动恢复、匀速运动等
         completion:动画完成回调方法
         */
//        UIView.animate(withDuration: 5.0, animations: {
//            self._imageView?.center = location
//        }) { (Bool) in
//            print("动画结束")
//        }
        
        //开始动画
//        UIView.beginAnimations("KCBasicAnimation", context: nil)
//        UIView.setAnimationDuration(5.0)
        //[UIView setAnimationDelay:1.0];//设置延迟
        //[UIView setAnimationRepeatAutoreverses:NO];//是否回复
        //[UIView setAnimationRepeatCount:10];//重复次数
        //[UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
        //[UIView setAnimationDelegate:self];//设置代理
        //[UIView setAnimationWillStartSelector:(SEL)];//设置动画开始运动的执行方法
        //[UIView setAnimationDidStopSelector:(SEL)];//设置动画运行结束后的执行方法
        
//        _imageView!.center=location;
        
        
        //开始动画
//        UIView.commitAnimations()
        
        
        /*创建弹性动画
         damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
         velocity:弹性复位的速度
         */
        UIView.animate(withDuration: 5.0, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveLinear, animations: {
            self._imageView!.center=location; //CGPointMake(160, 284);

        }) { (Bool) in
            
        }
    }

}
