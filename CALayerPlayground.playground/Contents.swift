//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let frame = CGRectMake(0, 0, 600, 600)

func gradientLayer() {
    let gradientView = UIView(frame: frame)
    XCPShowView("GradientView", view: gradientView)
    gradientView.backgroundColor = UIColor.whiteColor()
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = frame
    
    gradientLayer.backgroundColor = UIColor.greenColor().CGColor
    gradientLayer.colors = [
        UIColor.redColor().CGColor,
        UIColor.greenColor().CGColor,
        UIColor.blueColor().CGColor
    ]
    
    gradientLayer.locations = [0.0, 0.4, 0.8, 1]
    gradientLayer.frame.size.width /= 2
    gradientLayer.frame.size.height /= 2
    gradientLayer.startPoint = CGPointMake(0.0, 0.0)
    gradientLayer.endPoint = CGPointMake(1.0, 1.0)
    gradientLayer.cornerRadius = 50
    gradientLayer.masksToBounds = true
//
    gradientView.layer.addSublayer(gradientLayer)
    gradientView

    // adding gradient to UILabel text
    let label = UILabel(frame: gradientView.frame)
    gradientView.addSubview(label)
    label.text = "Okay - now let’s mask the gradient with the label… “What?” some of you are certainly saying just now. Well - just give it a try, will you?"
    label.numberOfLines = 0
    label.font = UIFont.systemFontOfSize(60)
  
    gradientLayer.mask = label.layer
}


func textLayer() {
    let textView = UIView(frame: frame)
    XCPShowView("TextView", view: textView)
    textView.backgroundColor = UIColor.whiteColor()
    
    let textLayer = CATextLayer()
    textLayer.frame = textView.frame
    textLayer.frame.size.width -= 20
    textLayer.frame.origin.x += 10
    textLayer.string = "CATextLayer disables sub-pixel antialiasing when rendering text. Text can only be drawn using sub-pixel antialiasing when it is composited into an existing opaque background at the same time that it's rasterized. There is no way to draw text with sub-pixel antialiasing by itself, whether into an image or a layer, in advance of having the background pixels to weave the text pixels into. Setting the opacity property of the layer to YES does not change the rendering mode."
    
    textLayer.foregroundColor = UIColor.darkGrayColor().CGColor
    textLayer.wrapped = true
    textLayer.fontSize = 32
    textLayer.alignmentMode = kCAAlignmentJustified
    textLayer.truncationMode = kCATruncationEnd
    textLayer.masksToBounds = true
    
    let anim = CABasicAnimation(keyPath: "fontSize")
    anim.duration = 2.0
    anim.toValue = 32
    anim.fromValue = 12
    textLayer.addAnimation(anim, forKey: nil)
    
    textView.layer.addSublayer(textLayer)
}


func shapeLayerHouse() {
    let shapeView = UIView(frame: frame)
    XCPShowView("ShapeView", view: shapeView)
    shapeView.backgroundColor = UIColor.whiteColor()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = shapeView.frame
    shapeLayer.fillColor = UIColor.greenColor().CGColor
    shapeLayer.strokeColor = UIColor.redColor().CGColor
    shapeLayer.strokeStart = 0.02
    shapeLayer.strokeEnd = 0.98
    shapeLayer.lineJoin = kCALineJoinBevel
    shapeLayer.lineWidth = 10
    shapeLayer.lineDashPhase = 50
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.lineDashPattern = [25, 15]
    
    
    let path = UIBezierPath()
    path.moveToPoint(CGPointMake(10, 150))
    path.addLineToPoint(CGPointMake(590, 150))
    path.addLineToPoint(CGPointMake(590, 400))
    path.addLineToPoint(CGPointMake(10, 400))
    path.addLineToPoint(CGPointMake(10, 150))
    path.addLineToPoint(CGPointMake(300, 10))
    path.addLineToPoint(CGPointMake(590, 150))
    shapeLayer.path = path.CGPath
    
    let newPath = UIBezierPath(ovalInRect: CGRectMake(20, 20, 400, 400)).CGPath
    let anim = CABasicAnimation(keyPath: "path")
    anim.toValue = newPath
    anim.duration = 4.0
    anim.beginTime = CACurrentMediaTime() + CFTimeInterval(5.0)
    anim.removedOnCompletion = false
    anim.fillMode = kCAFillModeForwards
//    shapeLayer.addAnimation(anim, forKey: nil)

    shapeLayer.geometryFlipped = true
    
    shapeView.layer.addSublayer(shapeLayer)
}


func replicatorLayerSpinner() {
    let replicatorView = UIView(frame: frame)
    XCPShowView("ReplicatorView", view: replicatorView)
    replicatorView.backgroundColor = UIColor.whiteColor()
    
    // settings
    let dotsCount: Int = 16
    let duration: CFTimeInterval = 1.5
    
    // setup replicator layer
    let sideLength = min(CGRectGetWidth(frame), CGRectGetHeight(frame))
    let replicatorLayer = CAReplicatorLayer()
    replicatorLayer.frame = CGRectMake(0, 0, sideLength, sideLength)
    replicatorLayer.position = replicatorView.center
    replicatorLayer.instanceCount = dotsCount
    let angle = CGFloat(2 * M_PI) / CGFloat(dotsCount)
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    replicatorLayer.instanceDelay = duration / Double(dotsCount)
    
    // setup dot layer
    let dot = CALayer()
    dot.frame = CGRectMake(0, 0, sideLength * 0.1, sideLength * 0.15)
    dot.backgroundColor = UIColor.blueColor().CGColor
    dot.position = CGPointMake(sideLength / 2.0, sideLength * 0.1)
    dot.cornerRadius = sideLength * 0.05
    // fix dots original size at animation beggining
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    
    // add shrink animation
    let shrink = CABasicAnimation(keyPath: "transform.scale")
    shrink.fromValue = 1.0
    shrink.toValue = 0.1
    shrink.duration = duration
    shrink.repeatCount = Float.infinity
    dot.addAnimation(shrink, forKey: nil)
    
    // add fade animation
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 1.0
    fade.toValue = 0.1
    fade.duration = duration
    fade.repeatCount = Float.infinity
    dot.addAnimation(fade, forKey: nil)
    
    let color = CABasicAnimation(keyPath: "backgroundColor")
    color.fromValue = UIColor.blueColor().CGColor
    color.toValue = UIColor.redColor().CGColor
    color.duration = duration
    color.repeatCount = Float.infinity
    dot.addAnimation(color, forKey: nil)
    
    replicatorLayer.addSublayer(dot)
    replicatorView.layer.addSublayer(replicatorLayer)
}

func replicatorLayerDotProgress() {
    let view = UIView(frame: frame)
    XCPShowView("Progress View", view: view)
    view.backgroundColor = UIColor.whiteColor()
    
    // setting
    let dotsCount: Int = 5
    let duration: CFTimeInterval = 0.6
    let dotSize = min(CGRectGetHeight(view.frame) * CGFloat(dotsCount), CGRectGetWidth(view.frame)) / CGFloat(dotsCount)
    let dotSpacing = (CGRectGetWidth(view.frame) - dotSize) / CGFloat(dotsCount - 1)
    
    // setup replicator layer
    let r = CAReplicatorLayer()
    r.frame = view.frame
    r.position = view.center
    r.instanceCount = dotsCount
    r.instanceDelay = duration / Double(dotsCount)
    r.instanceTransform = CATransform3DMakeTranslation(dotSpacing, 0, 1.0)
    
    // setup dot layer
    let dot = CALayer()
    dot.frame = CGRectMake(0, 0, dotSize - 10, dotSize - 10)
    dot.position.y = CGRectGetMidY(r.frame)
    dot.backgroundColor = UIColor.blueColor().CGColor
    dot.cornerRadius = CGRectGetHeight(dot.frame) / 2.0
    dot.opacity = 1.0
    
    let shrink = CABasicAnimation(keyPath: "transform.scale")
    shrink.fromValue = 1.0
    shrink.toValue = 0.5
    shrink.duration = duration
    shrink.autoreverses = true
    shrink.repeatCount = Float.infinity
    shrink.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//    dot.addAnimation(shrink, forKey: nil)
    
    let fade = CABasicAnimation(keyPath: "backgroundColor")
    fade.fromValue = UIColor.blueColor().CGColor
    fade.toValue = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 1.0).CGColor
    fade.duration = duration
    fade.autoreverses = true
    fade.repeatCount = Float.infinity
//    dot.addAnimation(fade, forKey: nil)
    
    r.addSublayer(dot)
    view.layer.addSublayer(r)
}


func emitterLayer() {
    let view = UIView(frame: CGRectMake(0, 0, 500, 500))
    XCPShowView("Emitter View", view: view)
    view.backgroundColor = UIColor.whiteColor()
    
    let e = CAEmitterLayer()
    e.frame = view.frame
    e.emitterSize = CGSizeMake(450, 20)
    e.emitterPosition = CGPointMake(200, -50)
    e.emitterZPosition = 1
    e.emitterShape = kCAEmitterLayerLine
    e.renderMode = kCAEmitterLayerOldestLast
    e.drawsAsynchronously = true
  
    
    let cell = CAEmitterCell()
    cell.scale = 1.0
    cell.lifetime = 7.0
    cell.birthRate = 50
    cell.yAcceleration = 50
    cell.xAcceleration = 5
    let image = UIImage(named: "star")
    cell.contents = image?.CGImage
    cell.spin = 0.5
    
    e.emitterCells = [cell]
    
    view.layer.addSublayer(e)
}

func basicLayer() {
    let view = UIView(frame: frame)
    XCPShowView("Basic View", view: view)
    view.backgroundColor = UIColor.whiteColor()
    
    let l = CALayer()
    l.frame = CGRectMake(0, 0, 400, 400)
    l.position = view.center
    
    l.contents = UIImage(named: "zack.jpg")?.CGImage
    l.contentsGravity = kCAGravityResizeAspectFill

    l.borderColor = UIColor.brownColor().CGColor
    l.borderWidth = 15
    l.cornerRadius = 100
    l.masksToBounds = true
    
    l.shadowColor = UIColor.blackColor().CGColor
    l.shadowRadius = 50
    l.shadowOpacity = 0.8
    l.shadowOffset = CGSizeMake(50, 50)
    
    view.layer.addSublayer(l)
}

let choice = 3

switch choice {
case 1: gradientLayer()
case 2: textLayer()
case 3: shapeLayerHouse()
case 4: replicatorLayerSpinner()
case 5: replicatorLayerDotProgress()
case 6: emitterLayer()
case 7: basicLayer()
default: break
}


