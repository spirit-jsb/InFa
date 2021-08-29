//
//  VMStarLayer.swift
//  InFa
//
//  Created by Max on 2021/8/21.
//

#if canImport(UIKit)

import UIKit

struct VMStarLayer {
  
  static func create(size: CGFloat, fillColor: UIColor?, strokeColor: UIColor?, lineWidth: CGFloat) -> CALayer {
    let containerLayer = self.createContainerLayer(size)
    
    let starPath = self.createStarPath(size: size, lineWidth: lineWidth)
    let starLayer = self.createShapeLayer(starPath: starPath.cgPath, size: size, fillColor: fillColor, strokeColor: strokeColor, lineWidth: lineWidth)
    
    containerLayer.addSublayer(starLayer)
    
    return containerLayer
  }
  
  static func create(starImage: UIImage?, size: CGFloat, tintColor: UIColor?) -> CALayer {
    let containerLayer = self.createContainerLayer(size)
    
    let starImageLayer = self.createContainerLayer(size)
    starImageLayer.contents = starImage?.cgImage
    starImageLayer.contentsGravity = .resizeAspect
    
    let starContainerLayer = self.createContainerLayer(size)
    starContainerLayer.mask = starImageLayer
    if let tintColor = tintColor {
      starContainerLayer.backgroundColor = tintColor.cgColor
    }
    
    containerLayer.addSublayer(starContainerLayer)
    
    return containerLayer
  }
  
  private static func createContainerLayer(_ size: CGFloat) -> CALayer {
    let layer = CALayer()
    layer.bounds.size = CGSize(width: size, height: size)
    layer.anchorPoint = CGPoint()
    layer.masksToBounds = true
    layer.contentsScale = UIScreen.main.scale
    layer.isOpaque = true
    
    return layer
  }
  
  private static func createShapeLayer(starPath: CGPath?, size: CGFloat, fillColor: UIColor?, strokeColor: UIColor?, lineWidth: CGFloat) -> CAShapeLayer {
    let shapeLayer = CAShapeLayer()
    shapeLayer.bounds.size = CGSize(width: size, height: size)
    shapeLayer.anchorPoint = CGPoint()
    shapeLayer.masksToBounds = true
    shapeLayer.contentsScale = UIScreen.main.scale
    shapeLayer.isOpaque = true
    
    shapeLayer.path = starPath
    shapeLayer.fillColor = fillColor?.cgColor
    shapeLayer.strokeColor = strokeColor?.cgColor
    shapeLayer.lineWidth = lineWidth
    
    return shapeLayer
  }
  
  private static func createStarPath(size: CGFloat, lineWidth: CGFloat) -> UIBezierPath {
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars
    
    let corners: Int = 5
    let smoothness: CGFloat = 0.382
    
    let actualLineWidth = lineWidth + ceil(lineWidth * 0.3)
    let actualSize = size - actualLineWidth * 2.0
    
    // draw from the center of our rectangle
    let center = CGPoint(x: actualSize / 2.0, y: actualSize / 2.0)
    
    // start from directly upwards (as opposed to down or to the right)
    var currentAngle = -CGFloat.pi / 2.0
    
    // calculate how much we need to move with each star corner
    let angleAdjustment = CGFloat.pi * 2.0 / CGFloat(corners * 2)
    
    // figure out how much we need to move X/Y for the inner points of the star
    let innerX = center.x * smoothness
    let innerY = center.y * smoothness
    
    // we're ready to start with our path now
    let starPath = UIBezierPath()
    
    // move to our initial position
    starPath.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
    
    // track the lowest point we draw to, so we can center later
    var bottomEdge: CGFloat = 0.0
    
    // loop over all our points/inner points
    for corner in 0 ..< corners * 2 {
      // figure out the location of this point
      let sinAngle = sin(currentAngle)
      let cosAngle = cos(currentAngle)
      let bottom: CGFloat
      
      // if we're a multiple of 2 we are drawing the outer edge of the star
      if corner.isMultiple(of: 2) {
        // store this Y position
        bottom = center.y * sinAngle
        
        // and add a line to there
        starPath.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
      }
      else {
        // we're not a multiple of 2, which means we're drawing an inner point
        
        // store this Y position
        bottom = innerY * sinAngle
        
        // and add a line to there
        starPath.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
      }
      
      // if this new bottom point is our lowest, stash it away for later
      if bottom > bottomEdge {
        bottomEdge = bottom
      }
      
      currentAngle += angleAdjustment
    }
    
    // figure out how much unused space we have at the bottom of our drawing rectangle
    let unusedSpace = (actualSize / 2.0 - bottomEdge) / 2.0
    
    // create and apply a transform that moves our path down by that amount, centering the shape vertically
    let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
    
    starPath.apply(transform)
    
    return starPath
  }
}

#endif
