//
//  ImageTableViewCell.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit
import SDWebImage

class ImageTableViewCell: UITableViewCell {
  
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var displayLabel: UILabel!
  
  var mainImage: Image! {
    didSet {
      configureContentView()
    }
  }
  
  private func configureContentView() {
    displayLabel.text = mainImage.name
    activityIndicator.startAnimating()
    mainImageView.sd_setImage(with: URL(string: mainImage.url)) { (image, error, _, url) in
      self.mainImageView.image = image
      self.activityIndicator.stopAnimating()
    }
  }
}
