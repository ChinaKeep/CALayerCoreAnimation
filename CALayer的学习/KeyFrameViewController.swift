

//
//  KeyFrameViewController.swift
//  CALayer的学习
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class KeyFrameViewController: UIViewController {
    /*
     熟悉flash开发的朋友对于关键帧动画应该不陌生
     这种动画方式在flash开发中经常用到，关键帧动画就是在动画控制过程中开发者指定主要的动画状态
     至于各个状态间动画如何进行则由系统自动运算补充（每个挂念帧之间西戎形成的动画称为：“补间动画”，这种动画
     的好处就是开发者不用逐个控制每个动画帧，而只要关心几个关键帧的状态即可）
     
     关键帧动画的开发分为两种形式：
     一种是通过设置不同的属性进行关键帧控制
     另一种是通过绘制路径进行关键帧控制
     后者优先级高于前者，如果设置了路径则属性不再起作用
     
     */
    var _layer:CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景图（注意这个图片其实在根图层）
        let backgroundImage = UIImage.init(named: "girl.png")
        self.view.backgroundColor = UIColor.init(patternImage: backgroundImage!)
        
        _layer = CALayer()
        _layer?.bounds = CGRect.init(x: 0, y: 0, width: 10, height: 20)
        _layer?.position = CGPoint.init(x: 50, y: 150)
        _layer?.contents = UIImage.init(named: "kunkun.jpg")?.cgImage
        self.view.layer.addSublayer(_layer!)
        
        //创建动画
//        self.translationAnimation()
        self.translationAnimationPath()
    }
    //MARK:关键帧动画
    func translationAnimation()  {
        //1.创建关键帧动画并设置动画属性
        let keyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
        //2.设置关键帧，这里有4个关键帧
        let key1 = NSValue.init(cgPoint: (_layer?.position)!)//对于关键帧动画初始值不能省略
        let key2 = NSValue.init(cgPoint: CGPoint.init(x: 80, y: 220))
        let key3 = NSValue.init(cgPoint: CGPoint.init(x: 45, y: 300))
        let key4 = NSValue.init(cgPoint: CGPoint.init(x: 55, y: 400))
        
        let values = [key1,key2,key3,key4]
        keyframeAnimation.values = values
        
        //设置其他属性
        keyframeAnimation.duration = 8.0
        keyframeAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
        //3.添加动画到图层，添加动画后就会执行动画
        _layer?.add(keyframeAnimation, forKey: "kKeyframeAnimatioin_Position")
        
    }
    /*
     上面的关键帧动画固然比前面的基础动画好一些，但是其实还是存在问题，那就是花飞落的路径是直线
     当然这个直线是根据程序中设置的四个关键帧自动形成的，那么如何让它沿着曲线飘落？
     这就是第二种类型的关键帧动画，通过描述路径进行关键帧动画的控制
     
     */
    func translationAnimationPath()  {
        //1.创建关键帧动画并设置动画属性
        let keyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
        //2.设置路径
        //绘制贝塞尔曲线
        let path = CGMutablePath.init()
        //移动到起点位置
        path.move(to: CGPoint.init(x: (_layer?.position.x)!, y: (_layer?.position.y)!))
        //二次绘制贝塞尔曲线
        path.addCurve(to: CGPoint.init(x: 160, y: 280), control1: CGPoint.init(x: -30, y: 300), control2: CGPoint.init(x: 144, y: 400))
        keyframeAnimation.path  = path//设置path属性
        //设置其他属性
        keyframeAnimation.duration = 8.0
        keyframeAnimation.beginTime = CACurrentMediaTime() + 2;
        
        //3.添加动画到图层，添加动画后就会执行动画
        _layer?.add(keyframeAnimation, forKey: "kKeyframeAnimatioin_Position")
    }
    /*
     在关键帧动画中还有一些属性
     keyTimes:各个关键帧的时间控制。前面使用values设置了4个关键帧，默认情况下每两帧之间间隔为：8（4-1）秒
     如果想要控制动画从第一帧到第二帧占用时间4秒
     从第二帧到第三帧的时间为2秒，从第三帧到第四帧为2秒的话，就可以通过keyTimes进行设置
     keytims中存储的是时间占用比例点，此时设置keytimes的值为 0.0 0.5 0.75 1.0（当然必须转换为NSNumber）
     也就是说1到2帧运行总时间的50% 2到3帧运行到总时间的75% 3到4帧运行到8秒结束
     
     caculationMode:动画计算模式
     上面的keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3秒到第2帧
     是因为动画时连续的（值为kCAAnimationLinear这是计算模式的默认值）；
     而如果指定了动画模式为kCAAnimationDiscrete离散的那么就会看到动画从第一帧经过8/3秒到第二帧，中间没有任何过渡
     其他的动画模式
     kCCAnimationPaced（均匀执行，会忽略keyTimes）
     kCAAnmationCubic(平滑执行，对于位置变动关键帧动画运行轨迹更平滑)
     kCAAnimationCubicPaced(平滑均匀执行)
     
     */


}
