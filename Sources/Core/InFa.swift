//
//  InFa.swift
//  InFa
//
//  Created by Max on 2021/8/22.
//

#if canImport(UIKit)

import UIKit

public protocol VMStarConfigurationProtocol {
  
  var totalStars: Int { set get }
  
  var starSize: CGFloat { set get }
  
  var starMargin: CGFloat { set get }
  
  var fillMode: VMStarFillMode { set get }
  
  var emptyBackgroundColor: UIColor? { set get }
  
  var filledBackgroundColor: UIColor? { set get }
  
  var emptyBorderColor: UIColor? { set get }
  var emptyBorderWidth: CGFloat { set get }
  
  var filledBorderColor: UIColor? { set get }
  var filledBorderWidth: CGFloat { set get }
  
  var emptyStarImage: UIImage? { set get }
  
  var filledStarImage: UIImage? { set get }
  
  var emptyStarImageTintColor: UIColor? { set get }
  
  var filledStarImageTintColor: UIColor? { set get }
  
  var minTouchRating: Float { set get }
  
  var blockingTouches: Bool { set get }
  
  var updateByTouch: Bool { set get }
  
  var disabledPanGestures: Bool { set get }
}

public enum VMStarFillMode {
  case full
  case half
  case precise
}

#endif
