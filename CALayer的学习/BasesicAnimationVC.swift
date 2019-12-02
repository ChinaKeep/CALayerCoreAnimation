

//
//  BasesicAnimationVC.swift
//  CALayer的学习
//
//  Created by apple on 2019/11/29.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class BasesicAnimationVC: UIViewController {
    var _layer:CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         如果不使用UIView封装的动画，动画创建一般分为以下几个步骤：
         1.初始化动画并设置动画属性
         2.设置动画属性初始值（可以省略）结束值以及其他属性
         3.给图层添加动画
         */
        let image = UIImage.init(named: "girl.png")
        
        self.view.backgroundColor = UIColor.init(patternImage: image!)
        //自定义一个图层
        _layer = CALayer.init()
        _layer?.bounds = CGRect.init(x: 0, y: 0, width: 10, height: 20)
        _layer?.position = CGPoint.init(x: 50, y: 150)
        _layer?.contents = UIImage.init(named: "kunkun.jpg")?.cgImage
        self.view.layer.addSublayer(_layer!)
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()
        //        let layer = self.view.layer.sublayers![0]
        //        var width = layer.bounds.size.width
        //        if width == WIDTH {
        //            width = WIDTH * 4
        //        }else{
        //            width = WIDTH
        //        }
        //        layer.bounds = CGRect.init(x: 0, y: 0, width: width, height: width)
        //        layer.position = (touch as! UITouch).location(in:self.view)     //获取当前点击位置
        //        layer.cornerRadius = width / 2
        
        let point = (touch as! UITouch).location(in:self.view)
        
        self.translationAnimation(point: point)
        
    }
    
    func translationAnimation(point location:CGPoint) {
        //1.创建动画，并制定动画属性
        let basicAnimation = CABasicAnimation.init(keyPath: "position")
        //2.设置动画属性初始值和结束值
        basicAnimation.toValue = NSValue.init(cgPoint: location)
        //设置其他动画属性
        basicAnimation.duration = 5.0
        basicAnimation.repeatCount = HUGE
        // 3.添加动画到图层 ，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
        _layer?.add(basicAnimation, forKey: "KCBasicAnimation_Translation")
        
    }

}
