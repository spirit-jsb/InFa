//
//  VMStarSizeHelper.swift
//  InFa
//
//  Created by Max on 2021/8/29.
//

#if canImport(UIKit)

import UIKit

struct VMStarSizeHelper {
  
  static func calculateContentSize(layers: [CALayer]) -> CGSize {
    var size = CGSize()
    
    for layer in layers {
      if layer.frame.maxX > size.width {
        size.width = layer.frame.maxX
      }
      if layer.frame.maxY > size.height {
        size.height = layer.frame.maxY
      }
    }
    
    return size
  }
}

#endif
