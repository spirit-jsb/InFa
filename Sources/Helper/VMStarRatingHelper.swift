//
//  VMStarRatingHelper.swift
//  InFa
//
//  Created by Max on 2021/8/29.
//

#if canImport(Foundation)

import Foundation

struct VMStarRatingHelper {
  
  static func actualRating(fromRating rating: Float, fillMode: VMStarFillMode, totalStars: Int) -> Float {
    let floorRating = floor(rating)
    let remainderRating = rating - floorRating

    var actualRating = floorRating + self.starFillLevel(remainderRating: remainderRating, fillMode: fillMode)
    actualRating = min(Float(totalStars), actualRating)
    actualRating = max(0.0, actualRating)

    return actualRating
  }
  
  static func actualRating(fromRating rating: Float, totalStars: Int) -> Float {
    return max(0.0, min(rating, Float(totalStars)))
  }
  
  static func starFillLevel(remainderRating: Float, fillMode: VMStarFillMode) -> Float {
    var result = remainderRating
    
    if result > 1.0 {
      result = 1.0
    }
    if result < 0.0 {
      result = 0.0
    }
        
    return self.roundStarFillLevel(result, fillMode: fillMode)
  }
  
  private static func roundStarFillLevel(_ starFillLevel: Float, fillMode: VMStarFillMode) -> Float {
    switch fillMode {
    case .full:
      return round(starFillLevel)
    case .half:
      return round(starFillLevel * 2.0) / 2.0
    case .precise:
      return starFillLevel
    }
  }
}

#endif
