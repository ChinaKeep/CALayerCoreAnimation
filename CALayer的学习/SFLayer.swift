//
//  SFLayer.swift
//  CALayer的学习
//
//  Created by apple on 2019/11/28.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

class SFLayer: CALayer {
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1).cgColor)
        ctx.setStrokeColor(UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1).cgColor)
        
        //起点位置
        ctx.move(to: CGPoint.init(x: 94.5, y: 33.5))
        
        //开始画线
        ctx.addLine(to: CGPoint.init(x: 104.02, y: 47.39))
        ctx.addLine(to: CGPoint.init(x: 120.18, y: 52.16))
        ctx.addLine(to: CGPoint.init(x: 109.9, y: 65.51))
        ctx.addLine(to: CGPoint.init(x: 110.37, y: 82.34))
        ctx.addLine(to: CGPoint.init(x: 94.5, y: 76.7))
        ctx.addLine(to: CGPoint.init(x: 78.63, y: 82.34))
        ctx.addLine(to: CGPoint.init(x: 79.09, y: 65.51))
        ctx.addLine(to: CGPoint.init(x: 68.82, y: 52.16))
        ctx.addLine(to: CGPoint.init(x: 84.98, y: 47.39))
        ctx.closePath()
        
        ctx.drawPath(using: CGPathDrawingMode.fill)
        
    }
}
