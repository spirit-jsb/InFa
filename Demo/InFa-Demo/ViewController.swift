//
//  ViewController.swift
//  InFa-Demo
//
//  Created by Max on 2021/8/21.
//

import UIKit
import InFa

class ViewController: UIViewController {
  
  lazy var fullTitleView: UILabel = {
    let titleView = UILabel()
    titleView.text = "Full"
    titleView.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
    titleView.textColor = UIColor(red: 0.6, green: 0.882, blue: 0.918, alpha: 1.0)
    return titleView
  }()
  
  lazy var fullStarView: VMStarView = {
    let starView = VMStarView()
    starView.configuration.emptyBackgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.0)
    starView.configuration.filledBackgroundColor = UIColor(red: 0.967, green: 0.969, blue: 0.988, alpha: 1.0)
    starView.configuration.emptyBorderColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.0)
    starView.configuration.filledBorderColor = UIColor(red: 0.967, green: 0.969, blue: 0.988, alpha: 1.0)
    return starView
  }()
  
  lazy var halfTitleView: UILabel = {
    let titleView = UILabel()
    titleView.text = "Half"
    titleView.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
    titleView.textColor = UIColor(red: 0.6, green: 0.882, blue: 0.918, alpha: 1.0)
    return titleView
  }()
  
  lazy var halfStarView: VMStarView = {
    let starView = VMStarView()
    starView.configuration.starSize = 40.0
    starView.configuration.starMargin = 8.0
    starView.configuration.fillMode = .half
    starView.configuration.filledBackgroundColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    starView.configuration.emptyBorderColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    starView.configuration.filledBorderColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    return starView
  }()
  
  lazy var preciseTitleView: UILabel = {
    let titleView = UILabel()
    titleView.text = "Precise"
    titleView.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
    titleView.textColor = UIColor(red: 0.6, green: 0.882, blue: 0.918, alpha: 1.0)
    return titleView
  }()
  
  lazy var preciseStarView: VMStarView = {
    let starView = VMStarView()
    starView.configuration.starSize = 60.0
    starView.configuration.starMargin = 11.0
    starView.configuration.fillMode = .precise
    starView.configuration.filledBackgroundColor = UIColor(red: 1, green: 0.714, blue: 0.047, alpha: 1.0)
    starView.configuration.emptyBorderColor = UIColor(red: 1, green: 0.714, blue: 0.047, alpha: 1.0)
    starView.configuration.emptyBorderWidth = 2.0
    starView.configuration.filledBorderColor = UIColor(red: 1, green: 0.714, blue: 0.047, alpha: 1.0)
    starView.configuration.filledBorderWidth = 2.0
    return starView
  }()
  
  lazy var ratingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
    label.textColor = UIColor(red: 0.6, green: 0.882, blue: 0.918, alpha: 1.0)
    return label
  }()
  
  lazy var ratingSlider: UISlider = {
    let slider = UISlider()
    slider.minimumValue = -1.0
    slider.maximumValue = 6.0
    slider.minimumTrackTintColor = UIColor(red: 0.149, green: 0.663, blue: 0.729, alpha: 1.0)
    slider.maximumTrackTintColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.0)
    slider.thumbTintColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    slider.addTarget(self, action: #selector(changedRating(_:)), for: .valueChanged)
    return slider
  }()
  
  private lazy var titleAndStarStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.fullTitleView, self.fullStarView, self.halfTitleView, self.halfStarView, self.preciseTitleView, self.preciseStarView, self.ratingLabel, self.ratingSlider])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 8.0
    
    if #available(iOS 11.0, *) {
      stackView.setCustomSpacing(32.0, after: self.fullStarView)
      stackView.setCustomSpacing(32.0, after: self.halfStarView)
      stackView.setCustomSpacing(48.0, after: self.preciseStarView)
      stackView.setCustomSpacing(16.0, after: self.ratingLabel)
    }
    
    return stackView
  }()
  
  private let rating: Float = 2.021821
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.constructViewHierarchy()
    self.activateConstraints()
    self.bind()
  }
  
  private func constructViewHierarchy() {
    self.view.addSubview(self.titleAndStarStackView)
  }
  
  private func activateConstraints() {
    if #available(iOS 11.0, *) {
    self.titleAndStarStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
    }
    else {
      self.titleAndStarStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
    }
    self.titleAndStarStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
    self.ratingSlider.widthAnchor.constraint(equalToConstant: 320.0).isActive = true
  }
  
  private func bind() {
    self.fullStarView.onTouchingRating = self.onTouchingRating
    self.halfStarView.onTouchingRating = self.onTouchingRating
    self.preciseStarView.onTouchingRating = self.onTouchingRating
    
    self.fullStarView.endTouchingRating = self.endTouchingRating
    self.halfStarView.endTouchingRating = self.endTouchingRating
    self.preciseStarView.endTouchingRating = self.endTouchingRating
    
    self.ratingSlider.value = self.rating
    self.updateRating(nil)
  }
  
  private func updateRating(_ touchingRating: Float?) {
    var newRating: Float = 0.0
    
    if let touchingRating = touchingRating {
      newRating = touchingRating
    }
    else {
      newRating = self.ratingSlider.value
    }
    
    self.fullStarView.rating = newRating
    self.halfStarView.rating = newRating
    self.preciseStarView.rating = newRating
    
    self.ratingLabel.text = self.ratingDescription(newRating)
  }
  
  private func onTouchingRating(_ rating: Float) {
    self.ratingSlider.value = rating
    self.updateRating(rating)
  }
  
  private func endTouchingRating(_ rating: Float) {
    self.ratingSlider.value = rating
  }
  
  @objc private func changedRating(_ slider: UISlider) {
    self.updateRating(nil)
  }
  
  private func ratingDescription(_ rating: Float) -> String {
    return String(format: "%.2f", rating)
  }
}
