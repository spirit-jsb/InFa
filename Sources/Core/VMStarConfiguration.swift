//
//  VMStarConfiguration.swift
//  InFa
//
//  Created by Max on 2021/8/24.
//

#if canImport(UIKit)

import UIKit

public struct VMStarConfiguration {
  
  public var totalStars: Int = 5
  
  public var starSize: CGFloat = 20.0
  
  public var starMargin: CGFloat = 5.0
  
  public var fillMode: VMStarFillMode = .full
  
  public var emptyBackgroundColor: UIColor? = UIColor.clear
  
  public var filledBackgroundColor: UIColor? = UIColor(red: 0.949, green: 0.275, blue: 0.227, alpha: 1.0)
  
  public var emptyBorderColor: UIColor? = UIColor(red: 0.949, green: 0.275, blue: 0.227, alpha: 1.0)
  public var emptyBorderWidth: CGFloat = 1.0 / UIScreen.main.scale
  
  public var filledBorderColor: UIColor? = UIColor(red: 0.949, green: 0.275, blue: 0.227, alpha: 1.0)
  public var filledBorderWidth: CGFloat = 1.0 / UIScreen.main.scale
  
  public var emptyStarImage: UIImage? = nil
  
  public var filledStarImage: UIImage? = nil
  
  public var emptyStarImageTintColor: UIColor? = nil
  
  public var filledStarImageTintColor: UIColor? = nil
  
  public var minTouchRating: Float = 1.0
  
  public var blockingTouches: Bool = true
  
  public var updateByTouch: Bool = true
  
  public var disabledPanGestures: Bool = false
  
  public static var `default` = VMStarConfiguration()
  
  public init() {
    
  }
}

#endif
