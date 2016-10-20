//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)

func gradientLayer() {
    let gradientView = UIView(frame: frame)
    XCPlaygroundPage.currentPage.liveView = gradientView
    gradientView.backgroundColor = UIColor.white
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = frame
    
    gradientLayer.backgroundColor = UIColor.green.cgColor
    gradientLayer.colors = [
        UIColor.red.cgColor,
        UIColor.green.cgColor,
        UIColor.blue.cgColor
    ]
    
    
    gradientLayer.locations = [0.0, 0.4, 0.8, 1]
    gradientLayer.frame.size.width /= 2
    gradientLayer.frame.size.height /= 2
    gradientLayer.startPoint = CGPoint(x: 0, y:
        
        0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
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
    label.font = UIFont.systemFont(ofSize: 60)
    
    gradientLayer.mask = label.layer
}


func textLayer() {
    let textView = UIView(frame: frame)
    XCPlaygroundPage.currentPage.liveView = textView
    textView.backgroundColor = UIColor.white
    
    let textLayer = CATextLayer()
    textLayer.frame = textView.frame
    textLayer.frame.size.width -= 20
    textLayer.frame.origin.x += 10
    textLayer.string = "CATextLayer disables sub-pixel antialiasing when rendering text. Text can only be drawn using sub-pixel antialiasing when it is composited into an existing opaque background at the same time that it's rasterized. There is no way to draw text with sub-pixel antialiasing by itself, whether into an image or a layer, in advance of having the background pixels to weave the text pixels into. Setting the opacity property of the layer to YES does not change the rendering mode."
    
    textLayer.foregroundColor = UIColor.darkGray.cgColor
    textLayer.isWrapped = true
    textLayer.fontSize = 32
    textLayer.alignmentMode = kCAAlignmentJustified
    textLayer.truncationMode = kCATruncationEnd
    textLayer.masksToBounds = true
    
    let anim = CABasicAnimation(keyPath: "fontSize")
    anim.duration = 2.0
    anim.toValue = 32
    anim.fromValue = 12
    textLayer.add(anim, forKey: nil)
    
    textView.layer.addSublayer(textLayer)
}


func shapeLayerHouse() {
    let shapeView = UIView(frame: frame)
    XCPlaygroundPage.currentPage.liveView = shapeView
    shapeView.backgroundColor = UIColor.white
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = shapeView.frame
    shapeLayer.fillColor = UIColor.green.cgColor
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.strokeStart = 0.02
    shapeLayer.strokeEnd = 0.98
    shapeLayer.lineJoin = kCALineJoinBevel
    shapeLayer.lineWidth = 10
    shapeLayer.lineDashPhase = 50
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.lineDashPattern = [25, 15]
    
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 10, y: 150))
    path.addLine(to: CGPoint(x: 590, y: 150))
    path.addLine(to: CGPoint(x: 590, y: 400))
    path.addLine(to: CGPoint(x: 10, y: 400))
    path.addLine(to: CGPoint(x: 10, y: 150))
    path.addLine(to: CGPoint(x: 300, y: 10))
    path.addLine(to: CGPoint(x: 590, y: 150))
    shapeLayer.path = path.cgPath
    
    let newPath = UIBezierPath(ovalIn: CGRect(x: 20, y: 20, width: 400, height: 400)).cgPath
    let anim = CABasicAnimation(keyPath: "path")
    anim.toValue = newPath
    anim.duration = 4.0
    anim.beginTime = CACurrentMediaTime() + CFTimeInterval(5.0)
    anim.isRemovedOnCompletion = false
    
    anim.fillMode = kCAFillModeForwards
    shapeLayer.add(anim, forKey: nil)
    
    shapeLayer.isGeometryFlipped = true
    
    shapeView.layer.addSublayer(shapeLayer)
}


func replicatorLayerSpinner() {
    let replicatorView = UIView(frame: frame)
    XCPlaygroundPage.currentPage.liveView = replicatorView
    replicatorView.backgroundColor = UIColor.white
    
    // settings
    let dotsCount: Int = 16
    let duration: CFTimeInterval = 1.5
    
    // setup replicator layer
    let sideLength = min(frame.width, frame.height)
    let replicatorLayer = CAReplicatorLayer()
    replicatorLayer.frame = CGRect(x: 0, y: 0, width: sideLength, height: sideLength)
    replicatorLayer.position = replicatorView.center
    replicatorLayer.instanceCount = dotsCount
    let angle = CGFloat(2 * M_PI) / CGFloat(dotsCount)
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    replicatorLayer.instanceDelay = duration / Double(dotsCount)
    
    // setup dot layer
    let dot = CALayer()
    dot.frame = CGRect(x: 0, y: 0, width: sideLength * 0.1, height: sideLength * 0.15)
    dot.backgroundColor = UIColor.blue.cgColor
    dot.position = CGPoint(x: sideLength / 2.0, y: sideLength * 0.1)
    dot.cornerRadius = sideLength * 0.05
    // fix dots original size at animation beggining
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    
    // add shrink animation
    let shrink = CABasicAnimation(keyPath: "transform.scale")
    shrink.fromValue = 1.0
    shrink.toValue = 0.1
    shrink.duration = duration
    shrink.repeatCount = Float.infinity
    dot.add(shrink, forKey: nil)
    
    // add fade animation
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 1.0
    fade.toValue = 0.1
    fade.duration = duration
    fade.repeatCount = Float.infinity
    dot.add(fade, forKey: nil)
    
    let color = CABasicAnimation(keyPath: "backgroundColor")
    color.fromValue = UIColor.blue.cgColor
    color.toValue = UIColor.red.cgColor
    color.duration = duration
    color.repeatCount = Float.infinity
    dot.add(color, forKey: nil)
    
    replicatorLayer.addSublayer(dot)
    replicatorView.layer.addSublayer(replicatorLayer)
}

func replicatorLayerDotProgress() {
    let view = UIView(frame: frame)
    XCPlaygroundPage.currentPage.liveView = view
    view.backgroundColor = UIColor.white
    
    // setting
    let dotsCount: Int = 5
    let duration: CFTimeInterval = 0.6
    let dotSize = min(view.frame.height * CGFloat(dotsCount), view.frame.width) / CGFloat(dotsCount)
    let dotSpacing = (view.frame.width - dotSize) / CGFloat(dotsCount - 1)
    
    // setup replicator layer
    let r = CAReplicatorLayer()
    r.frame = view.frame
    r.position = view.center
    r.instanceCount = dotsCount
    r.instanceDelay = duration / Double(dotsCount)
    r.instanceTransform = CATransform3DMakeTranslation(dotSpacing, 0, 1.0)
    
    // setup dot layer
    let dot = CALayer()
    dot.frame = CGRect(x: 0, y: 0, width: dotSize - 10, height: dotSize - 10)
    dot.position.y = r.frame.midY
    dot.backgroundColor = UIColor.blue.cgColor
    dot.cornerRadius = dot.frame.height / 2.0
    dot.opacity = 1.0
    
    let shrink = CABasicAnimation(keyPath: "transform.scale")
    shrink.fromValue = 1.0
    shrink.toValue = 0.5
    shrink.duration = duration
    shrink.autoreverses = true
    shrink.repeatCount = Float.infinity
    shrink.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    dot.add(shrink, forKey: nil)
    
    let fade = CABasicAnimation(keyPath: "backgroundColor")
    fade.fromValue = UIColor.blue.cgColor
    fade.toValue = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 1.0).cgColor
    fade.duration = duration
    fade.autoreverses = true
    fade.repeatCount = Float.infinity
    dot.add(fade, forKey: nil)
    
    r.addSublayer(dot)
    view.layer.addSublayer(r)
}


func emitterLayer() {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    XCPlaygroundPage.currentPage.liveView = view
    view.backgroundColor = UIColor.white
    
    let e = CAEmitterLayer()
    e.frame = view.frame
    e.emitterSize = CGSize(width: 450, height: 20)
    e.emitterPosition = CGPoint(x: 200, y: -50)
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
    cell.contents = image?.cgImage
    cell.spin = 0.5
    
    e.emitterCells = [cell]
    
    view.layer.addSublayer(e)
}

func basicLayer() {
    let view = UIView(frame: frame)
    XCPlaygroundPage.currentPage.liveView = view
    view.backgroundColor = UIColor.white
    
    let l = CALayer()
    l.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
    l.position = view.center
    
    l.contents = UIImage(named: "zack.jpg")?.cgImage
    l.contentsGravity = kCAGravityResizeAspectFill
    
    l.borderColor = UIColor.brown.cgColor
    l.borderWidth = 15
    l.cornerRadius = 100
    l.masksToBounds = true
    
    l.shadowColor = UIColor.black.cgColor
    l.shadowRadius = 50
    l.shadowOpacity = 0.8
    l.shadowOffset = CGSize(width: 50, height: 50)
    
    view.layer.addSublayer(l)
}

let choice = 7

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
