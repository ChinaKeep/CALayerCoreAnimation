//
//  SFView.swift
//  CALayer的学习
//
//  Created by apple on 2019/11/28.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class SFView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    func setupUI() {
        let layer = SFLayer.init()
        layer.bounds = CGRect.init(x: 0, y: 0, width: 185, height: 185)
        /// position是相对于父视图的
        layer.position = CGPoint.init(x: 200, y: 300)
        layer.backgroundColor = UIColor.init(red: 0, green: 246/255, blue: 1.0, alpha: 1).cgColor;
        
        //显示图层
        layer.setNeedsDisplay()
        self.layer.addSublayer(layer)
        
        
    }
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
    }
}


































