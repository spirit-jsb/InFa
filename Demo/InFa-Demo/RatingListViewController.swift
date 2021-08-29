//
//  RatingListViewController.swift
//  InFa-Demo
//
//  Created by Max on 2021/8/29.
//

import UIKit

class RatingListViewController: UIViewController {
  
  private static let rowsCount = 100
  
  private var ratingDataSources = [Float](repeating: 0.0, count: RatingListViewController.rowsCount)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for index in 0 ..< RatingListViewController.rowsCount {
      self.ratingDataSources[index] = Float(index) / 99.0 * 5.0
    }
  }
}

extension RatingListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RatingListViewController.rowsCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "ratingListTableViewCell") as? RatingListTableViewCell {
      
      let rating = self.ratingDataSources[indexPath.row]
      cell.updateRating(rating)
      
      cell.preciseStarView.endTouchingRating = { [weak self] (rating) in
        self?.ratingDataSources[indexPath.row] = rating
      }
      
      return cell
    }
    
    return UITableViewCell()
  }
}
