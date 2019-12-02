
//
//  CADisplayLinkVC.swift
//  CALayer的学习
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class CADisplayLinkVC: UIViewController {

    /*
     虽然在核心动画没有直接提供逐帧动画类型，但是却提供了用于完成逐帧动画的相关对象CADisplayLink。CADisplayLink是一个计时器，但是同NSTimer不同的是，CADisplayLink的刷新周期同屏幕完全一致。例如在iOS中屏幕刷新周期是60次/秒，CADisplayLink刷新周期同屏幕刷新一致也是60次/秒，这样一来使用它完成的逐帧动画（又称为“时钟动画”）完全感觉不到动画的停滞情况。
     */
    let IMAGE_COUNT:NSInteger = 10
    var _layer: CALayer?
    var _index: Int?
    var _images :Array<UIImage>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage.init(named: "girl.png")?.cgImage
        _layer = CALayer()
        _layer?.bounds = CGRect.init(x: 0, y: 0, width: 87, height: 32)
        _layer?.position = CGPoint.init(x: 160, y: 284)
        self.view.layer.addSublayer(_layer!)
        
        //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
        //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
        _images = Array()
        for index in 0...9 {
            let imageName = String(format: "girl%i.png", index)
//            let image = UIImage.init(named: imageName)
//            _images?.append(image ?? UIImage.init(named:"kunkun.jpg")!)
            _images?.append(UIImage.init(named:"kunkun.jpg")!)

        }
        
        let displayLink = CADisplayLink.init(target: self, selector: #selector(step))
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        _index =  0
    }
    
    @objc func step(){
        var s : Int = 0
        
        //每秒执行6次
       s = s + 1
        if s % 10 == 0 {
            let image = _images![_index!]
            print(image)
            _layer?.contents = image.cgImage
            _index = (_index! + 1) % IMAGE_COUNT
        }
    }

}


extension Int{
    //前+
    static prefix  func ++(num:inout Int) -> Int  {
        num += 1
        return num
    }
    //后缀+
    static postfix  func ++(num:inout Int) -> Int  {
        let temp = num
        num += 1
        return temp
    }
    //前 -
    static prefix  func --(num:inout Int) -> Int  {
        num -= 1
        return num
    }
    //后-
    static postfix  func --(num:inout Int) -> Int  {
        let temp = num
        num -= 1
        return temp
    }
}
