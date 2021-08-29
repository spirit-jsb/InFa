//
//  RatingListTableViewCell.swift
//  InFa-Demo
//
//  Created by Max on 2021/8/29.
//

import UIKit
import InFa

class RatingListTableViewCell: UITableViewCell {
  
  lazy var preciseStarView: VMStarView = {
    let starView = VMStarView()
    starView.translatesAutoresizingMaskIntoConstraints = false
    starView.configuration.fillMode = .precise
    starView.configuration.filledBackgroundColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    starView.configuration.emptyBorderColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    starView.configuration.filledBorderColor = UIColor(red: 0.306, green: 0.792, blue: 0.859, alpha: 1.0)
    starView.configuration.blockingTouches = true
    return starView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.constructViewHierarchy()
    self.activateConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.constructViewHierarchy()
    self.activateConstraints()
  }
  
  override func prepareForReuse() {
    self.preciseStarView.prepareForReuse()
  }
  
  func updateRating(_ rating: Float) {
    self.preciseStarView.rating = rating
  }
  
  private func constructViewHierarchy() {
    self.contentView.addSubview(self.preciseStarView)
  }
  
  private func activateConstraints() {
    self.preciseStarView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    self.preciseStarView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
  }
}
