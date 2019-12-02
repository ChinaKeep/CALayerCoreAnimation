
//
//  LayerDrawVC.swift
//  CALayer的学习
//
//  Created by apple on 2019/11/29.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class LayerDrawVC: UIViewController ,CALayerDelegate{
    let WIDTH : CGFloat = 150
    /*
     在iOS 中CALayer的设计主要是了为了内容展示和动画操作，CALayer本身并不包含在UIKit中，它不能响应事件。由于CALayer在设计之初就考虑它的动画操作功能，CALayer很多属性在修改时都能形成动画效果，这种属性称为“隐式动画属性”。但是对于UIView的根图层而言属性的修改并不形成动画效果，因为很多情况下根图层更多的充当容器的做用，如果它的属性变动形成动画效果会直接影响子图层。另外，UIView的根图层创建工作完全由iOS负责完成，无法重新创建，但是可以往根图层中添加子图层或移除子图层
     */
    /*
     上面的代码虽然实现了动画，但是动画如何暂停，如何组合？我们是不清楚的
     所以需要了解核心动画Core Animation（包括Quartz Core框架中）
     核心动画中分类：基础动画、关键帧动画、动画组、转场动画
     */
    
    // ------------------ 视图控制器 --------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let size = UIScreen.main.bounds.size;
        
        let layer = CALayer.init()
        layer.bounds = CGRect.init(x: 0, y: 0, width: WIDTH, height: WIDTH)
        //设置中心点
        layer.position = CGPoint.init(x: size.width / 2 , y: size.height / 2)
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = WIDTH/2;
        layer.masksToBounds = true
        //        layer.shadowColor = UIColor.gray.cgColor;//阴影颜色
        //        layer.shadowOffset = CGSize.init(width: 2, height: 2)
        //        layer.shadowOpacity = 0.9
        //方法二
        //利用图层解决倒立问题
        //        layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1, 0, 0);
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
        
        layer.delegate = self
        
        self.view.layer.addSublayer(layer)
        //调用图层setNeedDisplay 否则代理方法不会被调用
        layer.setNeedsDisplay()
        
        //方法三
        //        let image:UIImage = UIImage.init(named: "kunkun.jpg")!
        //        layer.contents = image.cgImage
        
        //方法四
//        layer.setValue(Double.pi, forKeyPath:"transform.rotation.x")
        
    }
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.saveGState()
        
        //方法一
        //通过指定 x,y 缩放因子，可以倒转 x轴 和 y轴
        //        ctx.scaleBy(x: 1, y: -1)
        //沿着x轴 y轴进行平移操作
        //        ctx.translateBy(x: 0, y: -WIDTH)
        
        let image:UIImage = UIImage.init(named: "kunkun.jpg")!
        ctx.draw((image.cgImage!), in: CGRect.init(x: 0, y: 0, width: WIDTH, height: WIDTH))
        
        ctx.restoreGState()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()
                let layer = self.view.layer.sublayers![0]
                var width = layer.bounds.size.width
                if width == WIDTH {
                    width = WIDTH * 4
                }else{
                    width = WIDTH
                }
                layer.bounds = CGRect.init(x: 0, y: 0, width: width, height: width)
                layer.position = (touch as! UITouch).location(in:self.view)     //获取当前点击位置
                layer.cornerRadius = width / 2

    }

}
