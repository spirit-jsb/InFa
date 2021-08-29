//
//  UIView+InFa.swift
//  InFa
//
//  Created by Max on 2021/8/29.
//

#if canImport(UIKit)

import UIKit

extension UIView {
  
  public var isRightToLeft: Bool {
    return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft
  }
}

#endif
