//
//  VMStarTouchHelper.swift
//  InFa
//
//  Created by Max on 2021/8/29.
//

#if canImport(UIKit)

import UIKit

struct VMStarTouchHelper {
  
  static func optimizeHitBounds(_ bounds: CGRect) -> CGRect {
    let recommendHitSize: CGFloat = 44.0
    
    var expandHitWidth: CGFloat = recommendHitSize - bounds.width
    var expandHitHeight: CGFloat = recommendHitSize - bounds.height
    
    expandHitWidth = max(expandHitWidth, 0.0)
    expandHitHeight = max(expandHitHeight, 0.0)
    
    let expandHitBounds: CGRect = bounds.insetBy(dx: -expandHitWidth / 2.0, dy: -expandHitHeight / 2.0)
    
    return expandHitBounds
  }
  
  static func touchRating(configuration: VMStarConfiguration, position: CGFloat) -> Float {
    var rating = self.calculateRating(position: position, totalStars: configuration.totalStars, starSize: configuration.starSize, starMargin: configuration.starMargin)
    
    // sensitivity threshold value = 0.05
    if configuration.fillMode == .half {
      rating += 0.20
    }
    if configuration.fillMode == .full {
      rating += 0.45
    }
    rating = VMStarRatingHelper.actualRating(fromRating: rating, fillMode: configuration.fillMode, totalStars: configuration.totalStars)
    rating = max(rating, configuration.minTouchRating)
    
    return rating
  }
  
  private static func calculateRating(position: CGFloat, totalStars: Int, starSize: CGFloat, starMargin: CGFloat) -> Float {
    guard position >= 0 else {
      return 0.0
    }
    
    var remainingPosition = position
    
    var rating = Float(Int(position / (starSize + starMargin)))
    
    guard rating <= Float(totalStars) else {
      return Float(totalStars)
    }
    
    remainingPosition -= CGFloat(rating) * (starSize + starMargin)
    
    rating += remainingPosition > starSize ? Float(1.0) : Float(remainingPosition / starSize)

    return rating
  }
}

#endif
