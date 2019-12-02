//
//  TransitionAnimationVC.swift
//  CALayer的学习
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class TransitionAnimationVC: UIViewController {
    /*
     转场动画就是从一个场景以动画的形式过渡到另一个场景。转场动画的使用一般分为以下几个步骤：
     
     1.创建转场动画
     2.设置转场类型、子类型（可选）及其他属性
     3.设置转场后的新视图并添加动画到图层
     
     动画类型    说明    对应常量    是否支持方向设置
     公开API
     fade    淡出效果    kCATransitionFade    是
     movein    新视图移动到旧视图上    kCATransitionMoveIn    是
     push    新视图推出旧视图    kCATransitionPush    是
     reveal    移开旧视图显示新视图    kCATransitionReveal    是
     
     私有API         私有API只能通过字符串访问
     
     cube    立方体翻转效果    无    是
     oglFlip    翻转效果    无    是
     suckEffect    收缩效果    无    否
     rippleEffect    水滴波纹效果    无    否
     pageCurl    向上翻页效果    无    是
     pageUnCurl    向下翻页效果    无    是
     cameralIrisHollowOpen    摄像头打开效果    无    否
     cameraIrisHollowClose    摄像头关闭效果    无    否
     另外对于支持方向设置的动画类型还包含子类型：
     
     动画子类型    说明
     kCATransitionFromRight    从右侧转场
     kCATransitionFromLeft    从左侧转场
     kCATransitionFromTop    从顶部转场
     kCATransitionFromBottom    从底部转场

     */
    var _imageView: UIImageView?
    var _currentIndex:Int?
    let IMAGE_COUNT : NSInteger = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "转场动画"
        _imageView = UIImageView.init()
        _imageView?.frame = UIScreen.main.bounds
        _imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        _imageView?.image = UIImage.init(named: "girl.png")
        self.view.addSubview(_imageView!)
        
        let leftSwipGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(leftSwipe(gesture:)))
        leftSwipGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipGesture)
        
        
        let rightSwipGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(rightSwipeGesture(gesture:)))
        rightSwipGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipGesture)
        _currentIndex = 0
    }
    @objc func leftSwipe(gesture: UISwipeGestureRecognizer){
        self.transitonAnimation(isNext: true)
    }
    @objc func rightSwipeGesture(gesture:UISwipeGestureRecognizer)  {
        self.transitonAnimation(isNext: false)
    }
    //MARK:-- 转场动画 ---
    func transitonAnimation(isNext: Bool) {
        //创建转场动画
        let transition = CATransition.init()
        //2.设置动画类型 注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
        transition.type = CATransitionType(rawValue: "cube")
        //设置子类型
        if isNext {
            transition.subtype =  CATransitionSubtype.fromRight
        }else{
            transition.subtype = CATransitionSubtype.fromLeft
        }
        
        //设置动画时长
        transition.duration = 1.0
        //3.设置转场后的新视图添加转场动画
        _imageView?.image = self.getImage(isNext: isNext)
        _imageView?.layer.add(transition, forKey: "KCTransitionAnimation")
    }
    func getImage(isNext:Bool) -> UIImage {
        if isNext {
            _currentIndex = (_currentIndex! + 1) % IMAGE_COUNT
        }else{//向左滑动
            _currentIndex = (_currentIndex! - 1 + IMAGE_COUNT) % IMAGE_COUNT
        }
        let imageName = String(format: "%i.jpg", _currentIndex! )
        return UIImage.init(named:imageName) ??  UIImage.init(named:"girl.png")!
    }
}
