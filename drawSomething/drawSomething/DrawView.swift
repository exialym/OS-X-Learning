//
//  DrawView.swift
//  drawSomething
//
//  Created by exialym on 15/10/26.
//  Copyright © 2015年 exialym. All rights reserved.
//

import Cocoa

class DrawView: NSView {
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        //第一个例子：简单的矩形
//                NSColor.blueColor().setFill()
//                let path = NSBezierPath(rect: self.bounds)
//                path.fill()
        
        //第二个例子：带描边的圆角矩形
        //        let pathRect = NSInsetRect(self.bounds, 1, 1)//这个方法在不改变此矩形的中心点的情况下在x，y方向收窄规定的像素点
        //        let path = NSBezierPath(roundedRect: pathRect, xRadius: 10, yRadius: 10)
        //        path.lineWidth = 4
        //        NSColor.blueColor().setFill()
        //        NSColor.greenColor().setStroke()
        //        path.fill()
        //        path.stroke()
        //        //path.fill()//绘制操作都是按顺序执行的，如果在stroke后执行fill则fill会盖住一点stroke
        
        //第三个例子：自定义路径
        //        let bezierPath = NSBezierPath()
        //        let drawingRect = NSInsetRect(self.bounds, self.bounds.size.width * 0.05, self.bounds.height * 0.05)
        //        //得到需要的点
        //        let topLeft = CGPointMake(CGRectGetMinX(drawingRect),CGRectGetMaxY(drawingRect))
        //        let topRight = CGPointMake(CGRectGetMaxX(drawingRect),CGRectGetMaxY(drawingRect))
        //        let bottomLeft = CGPointMake(CGRectGetMinX(drawingRect),CGRectGetMinY(drawingRect))
        //        let bottomRight = CGPointMake(CGRectGetMaxX(drawingRect),CGRectGetMinY(drawingRect))
        //        let center = CGPointMake(CGRectGetMidX(drawingRect),CGRectGetMidY(drawingRect))
        //        bezierPath.moveToPoint(topLeft)
        //        bezierPath.lineToPoint(topRight)
        //        bezierPath.lineToPoint(bottomLeft)
        //        bezierPath.curveToPoint(bottomRight, controlPoint1: center, controlPoint2: center)
        //        bezierPath.closePath()
        //        NSColor.blueColor().setFill()
        //        NSColor.greenColor().setStroke()
        //        bezierPath.fill()
        //        bezierPath.stroke()
        
        //第四个例子：多条子路径
        //        let bezierPath = NSBezierPath()
        //        let squareRect = CGRectInset(dirtyRect, dirtyRect.size.width * 0.45, dirtyRect.size.height * 0.05)
        //        let circleRect = CGRectInset(dirtyRect, dirtyRect.size.width * 0.3, dirtyRect.size.height * 0.3)
        //        let cornerRadius : CGFloat = 20
        //        let circlePath = NSBezierPath(ovalInRect: circleRect)
        //        let squarePath = NSBezierPath(roundedRect: squareRect, xRadius: cornerRadius, yRadius: cornerRadius)
        //        bezierPath.appendBezierPath(circlePath)
        //        bezierPath.appendBezierPath(squarePath)
        //        NSColor.blueColor().setFill()
        //        bezierPath.fill()
        
        //第五个例子：绘制带阴影的图像
//        let drawingRect = CGRectInset(dirtyRect, dirtyRect.size.width * 0.1, dirtyRect.size.height * 0.1)
//        let cornerRadius:CGFloat = 20
//        let beizerPath = NSBezierPath(roundedRect: drawingRect, xRadius: cornerRadius, yRadius: cornerRadius)
//        //这个方法保存了图形上下文，比如描边和填充颜色，是否设置了阴影等
//        NSGraphicsContext.saveGraphicsState()
//        let shadow = NSShadow()
//        shadow.shadowColor = NSColor.blueColor()
//        shadow.shadowOffset = NSSize(width: 3, height: -3)
//        shadow.shadowBlurRadius = 10
//        shadow.set()//一旦设置好阴影，则绘制的所有图形都带阴影
//        
//        NSColor.redColor().setFill()
//        beizerPath.fill()
//        //取回刚才保存的上下文，在这之间的改变上下文的设置就被覆盖了。
//        NSGraphicsContext.restoreGraphicsState()
        
        //第六个例子：渐变
//        let drawingRect = CGRectInset(dirtyRect, dirtyRect.size.width * 0.1, dirtyRect.size.height * 0.1)
//        let cornerRadius:CGFloat = 20
//        let beizerPath = NSBezierPath(roundedRect: drawingRect, xRadius: cornerRadius, yRadius: cornerRadius)
//        let startColor = NSColor.blackColor()
//        let endColor = NSColor.whiteColor()
//        let gradient = NSGradient(startingColor: startColor, endingColor: endColor)
//        gradient?.drawInBezierPath(beizerPath, angle: 90)
        
        //第七个例子：变换
        let drawingRect = CGRectInset(dirtyRect, dirtyRect.size.width * 0.1, dirtyRect.size.height * 0.1)
        let cornerRadius:CGFloat = 20
        let rotationTransform = CGAffineTransformMakeRotation(CGFloat(M_PI) / 4.0)
        let beizerPath = NSBezierPath(roundedRect: drawingRect, xRadius: cornerRadius, yRadius: cornerRadius)
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextSaveGState(context)
        
        CGContextConcatCTM(context, rotationTransform)
        
        NSColor.redColor().setFill()
        beizerPath.fill()
        
        CGContextRestoreGState(context)
        
    }
    
}
