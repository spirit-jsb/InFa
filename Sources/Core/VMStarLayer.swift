//
//  VMStarLayer.swift
//  InFa
//
//  Created by Max on 2021/8/21.
//

#if canImport(UIKit)

import UIKit

struct VMStarLayer {
  
  static func create(starPoints: [CGPoint], size: CGFloat, fillColor: UIColor?, strokeColor: UIColor?, lineWidth: CGFloat) -> CALayer {
    let containerLayer = self.createContainerLayer(size)
    
    let starPath = self.createStarPath(starPoints: starPoints, size: size, lineWidth: lineWidth)
    let starLayer = self.createShapeLayer(starPath: starPath.cgPath, size: size, fillColor: fillColor, strokeColor: strokeColor, lineWidth: lineWidth)
    
    containerLayer.addSublayer(starLayer)
    
    return containerLayer
  }
  
  static func create(starImage: UIImage?, size: CGFloat) -> CALayer {
    let containerLayer = self.createContainerLayer(size)
    
    let starImageLayer = self.createContainerLayer(size)
    starImageLayer.contents = starImage?.cgImage
    starImageLayer.contentsGravity = .resizeAspect
    
    containerLayer.addSublayer(starImageLayer)
    
    return containerLayer
  }
  
  static func createContainerLayer(_ size: CGFloat) -> CALayer {
    let layer = CALayer()
    layer.bounds.size = CGSize(width: size, height: size)
    layer.anchorPoint = CGPoint()
    layer.masksToBounds = true
    layer.contentsScale = UIScreen.main.scale
    layer.isOpaque = true
    
    return layer
  }
  
  static func createShapeLayer(starPath: CGPath?, size: CGFloat, fillColor: UIColor?, strokeColor: UIColor?, lineWidth: CGFloat) -> CAShapeLayer {
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
  
  static func createStarPath(starPoints: [CGPoint], size: CGFloat, lineWidth: CGFloat) -> UIBezierPath {
    let actualLineWidth = lineWidth - ceil(lineWidth * 0.3)
    let actualSize = size - actualLineWidth * 2.0
    
    let actualStarPoints = self.scaleStar(starPoints: starPoints, factor: actualSize / 100.0, lineWidth: actualLineWidth)
    
    let path = UIBezierPath()
    defer {
      path.close()
    }
    
    path.move(to: actualStarPoints[0])
    
    let remainingActualStarPoints = Array(actualStarPoints[1 ..< actualStarPoints.count])
    for actualStarPoint in remainingActualStarPoints {
      path.addLine(to: actualStarPoint)
    }
    
    return path
  }
  
  static func scaleStar(starPoints: [CGPoint], factor: CGFloat, lineWidth: CGFloat) -> [CGPoint] {
    return starPoints.map { (starPoint) in
      return CGPoint(
        x: starPoint.x * factor + lineWidth,
        y: starPoint.y * factor + lineWidth
      )
    }
  }
}

#endif
