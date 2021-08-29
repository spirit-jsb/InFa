//
//  VMStarLayersHelper.swift
//  InFa
//
//  Created by Max on 2021/8/29.
//

#if canImport(UIKit)

import UIKit

struct VMStarLayersHelper {
  
  static func createStarLayers(configuration: VMStarConfiguration, rating: Float, isRightToLeft: Bool) -> [CALayer] {
    var actualRating = VMStarRatingHelper.actualRating(fromRating: rating, totalStars: configuration.totalStars)
    
    var starLayers = [CALayer]()
    for _ in 0 ..< configuration.totalStars {
      let starFillLevel = VMStarRatingHelper.starFillLevel(remainderRating: actualRating, fillMode: configuration.fillMode)
      
      let starLayer = self.createCompositeStarLayer(configuration: configuration, starFillLevel: starFillLevel, isRightToLeft: isRightToLeft)
      starLayers.append(starLayer)
      
      actualRating -= 1
    }
    
    if isRightToLeft {
      starLayers.reverse()
    }
    
    self.layoutStarLayers(starLayers, starMargin: configuration.starMargin)
    
    return starLayers
  }
  
  static func createCompositeStarLayer(configuration: VMStarConfiguration, starFillLevel: Float, isRightToLeft: Bool) -> CALayer {
    if starFillLevel >= 1.0 {
      return self.createStarLayer(configuration: configuration, isFilled: true)
    }
    
    if starFillLevel == 0.0 {
      return self.createStarLayer(configuration: configuration, isFilled: false)
    }
    
    return self.createPreciseStarLayer(configuration: configuration, starFillLevel: starFillLevel, isRightToLeft: isRightToLeft)
  }
  
  private static func createStarLayer(configuration: VMStarConfiguration, isFilled: Bool) -> CALayer {
    let size = configuration.starSize
    
    if let starImage = isFilled ? configuration.filledStarImage : configuration.emptyStarImage {
      let tintColor = isFilled ? configuration.filledStarImageTintColor : configuration.emptyStarImageTintColor
      
      return VMStarLayer.create(starImage: starImage, size: size, tintColor: tintColor)
    }
    
    let fillColor = isFilled ? configuration.filledBackgroundColor : configuration.emptyBackgroundColor
    let strokeColor = isFilled ? configuration.filledBorderColor : configuration.emptyBorderColor
    let lineWidth = isFilled ? configuration.filledBorderWidth : configuration.emptyBorderWidth
    
    return VMStarLayer.create(size: size, fillColor: fillColor, strokeColor: strokeColor, lineWidth: lineWidth)
  }
  
  private static func createPreciseStarLayer(configuration: VMStarConfiguration, starFillLevel: Float, isRightToLeft: Bool) -> CALayer {
    let emptyStarLayer = self.createStarLayer(configuration: configuration, isFilled: false)
    let filledStarLayer = self.createStarLayer(configuration: configuration, isFilled: true)
    
    let parentLayer = CALayer()
    parentLayer.bounds = CGRect(x: 0.0, y: 0.0, width: filledStarLayer.bounds.width, height: filledStarLayer.bounds.height)
    parentLayer.anchorPoint = CGPoint()
    parentLayer.contentsScale = UIScreen.main.scale
    
    parentLayer.addSublayer(emptyStarLayer)
    parentLayer.addSublayer(filledStarLayer)
    
    if isRightToLeft {
      let rotation = CATransform3DMakeRotation(.pi, 0.0, 1.0, 0.0)
      filledStarLayer.transform = CATransform3DTranslate(rotation, -filledStarLayer.bounds.width, 0.0, 0.0)
    }
    
    filledStarLayer.bounds.size.width *= CGFloat(starFillLevel)
    
    return parentLayer
  }
  
  private static func layoutStarLayers(_ starLayers: [CALayer], starMargin: CGFloat) {
    var positionX: CGFloat = 0.0
    
    for layer in starLayers {
      layer.position.x = positionX
      positionX += layer.bounds.width + starMargin
    }
  }
}

#endif
