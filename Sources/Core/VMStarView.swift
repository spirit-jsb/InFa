//
//  VMStarView.swift
//  InFa
//
//  Created by Max on 2021/8/29.
//

#if canImport(UIKit)

import UIKit

public class VMStarView: UIView {
  
  public var onTouchingRating: ((Float) -> Void)?
  public var endTouchingRating: ((Float) -> Void)?
  
  public var rating: Float = 1.0 {
    didSet {
      if oldValue != self.rating {
        self.update()
      }
    }
  }
  
  public var configuration: VMStarConfiguration = .default {
    didSet {
      self.update()
    }
  }
  
  private var viewSize: CGSize = CGSize()
  private var previousRating: Float = -2021.829
  
  public convenience init(configuration: VMStarConfiguration = .default) {
    self.init(frame: .zero, configuration: configuration)
  }
  
  public init(frame: CGRect, configuration: VMStarConfiguration) {
    super.init(frame: frame)
    
    self.configuration = configuration
    
    self.update()
    self.optimizationRendering()
  }

  public convenience override init(frame: CGRect) {
    self.init(frame: frame, configuration: .default)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override var intrinsicContentSize: CGSize {
    return self.viewSize
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    
    self.update()
  }
  
  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    if #available(iOS 13.0, *) {
      if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
        self.update()
      }
    }
  }
  
  public func update() {
    let starLayers = VMStarLayersHelper.createStarLayers(configuration: self.configuration, rating: self.rating, isRightToLeft: self.isRightToLeft)
    
    self.layer.sublayers = starLayers
    
    self.updateStarSize(starLayers: starLayers)
  }
  
  public func prepareForReuse() {
    self.previousRating = -2021.829
  }
  
  private func optimizationRendering() {
    // https://developer.apple.com/documentation/quartzcore/calayer/1410905-shouldrasterize
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
  
  private func updateStarSize(starLayers: [CALayer]) {
    self.viewSize = VMStarSizeHelper.calculateContentSize(layers: starLayers)
    self.invalidateIntrinsicContentSize()
    
    self.frame.size = self.intrinsicContentSize
  }
  
  private func locationX(touches: Set<UITouch>) -> CGFloat? {
    guard let touch = touches.first else {
      return nil
    }
    
    var locationX = touch.location(in: self).x
    if self.isRightToLeft {
      locationX = self.bounds.width - locationX
    }
    
    return locationX
  }
   
  private func onTouching(locationX: CGFloat) {
    let touchRating = VMStarTouchHelper.touchRating(configuration: self.configuration, position: locationX)
    
    if self.configuration.updateByTouch {
      self.rating = touchRating
    }
    
    guard touchRating != self.previousRating else {
      return
    }
    
    self.onTouchingRating?(touchRating)
    self.previousRating = touchRating
  }
}

extension VMStarView {
  
  public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let optimizedHitBounds = VMStarTouchHelper.optimizeHitBounds(self.bounds)
    return optimizedHitBounds.contains(point)
  }
  
  public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.configuration.disabledPanGestures ? !(gestureRecognizer is UIPanGestureRecognizer) : true
  }
  
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.configuration.blockingTouches {
      super.touchesBegan(touches, with: event)
    }
    
    guard let locationX = self.locationX(touches: touches) else {
      return
    }
    
    self.onTouching(locationX: locationX)
  }
  
  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.configuration.blockingTouches {
      super.touchesBegan(touches, with: event)
    }
    
    guard let locationX = self.locationX(touches: touches) else {
      return
    }
    
    self.onTouching(locationX: locationX)
  }
  
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.configuration.blockingTouches {
      super.touchesBegan(touches, with: event)
    }
    
    self.endTouchingRating?(self.rating)
  }
  
  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.configuration.blockingTouches {
      super.touchesBegan(touches, with: event)
    }
    
    self.endTouchingRating?(self.rating)
  }
}

#endif
