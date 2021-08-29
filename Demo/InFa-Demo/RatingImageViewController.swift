//
//  RatingImageViewController.swift
//  InFa-Demo
//
//  Created by Max on 2021/8/29.
//

import UIKit
import InFa

class RatingImageViewController: UIViewController {
  
  lazy var imageStarView: VMStarView = {
    let starView = VMStarView()
    starView.translatesAutoresizingMaskIntoConstraints = false
    starView.rating = 2.021829
    starView.configuration.fillMode = .precise
    starView.configuration.starSize = 45.0
    starView.configuration.emptyStarImage = UIImage(named: "infa_empty_star")
    starView.configuration.filledStarImage = UIImage(named: "infa_filled_star")
    return starView
  }()
  
  lazy var tintImageStarView: VMStarView = {
    let starView = VMStarView()
    starView.translatesAutoresizingMaskIntoConstraints = false
    starView.rating = 2.021829
    starView.configuration.starSize = 45.0
    starView.configuration.emptyStarImage = UIImage(named: "infa_empty_star")
    starView.configuration.filledStarImage = UIImage(named: "infa_filled_star")
    starView.configuration.emptyStarImageTintColor = UIColor(red: 0.996, green: 0.808, blue: 0.827, alpha: 1)
    starView.configuration.filledStarImageTintColor = UIColor(red: 0.949, green: 0.275, blue: 0.227, alpha: 1)
    return starView
  }()
  
  private lazy var imageStarStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.imageStarView, self.tintImageStarView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 30.0
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.constructViewHierarchy()
    self.activateConstraints()
  }
  
  private func constructViewHierarchy() {
    self.view.addSubview(self.imageStarStackView)
  }
  
  private func activateConstraints() {
    self.imageStarStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.imageStarStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
  }
}
