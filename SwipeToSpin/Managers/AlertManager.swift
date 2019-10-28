//
//  AlertManager.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class AlertManager {
  class func showError(title: String = "Error", message: String?, viewController: UIViewController) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    viewController.present(alertView, animated: true, completion: nil)
  }
}
