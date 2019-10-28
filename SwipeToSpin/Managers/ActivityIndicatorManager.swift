//
//  ActivityIndicatorManager.swift
//  SwipeToSpin
//
//  Created by Bali on 21/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation
import SVProgressHUD

class ActivityIndicatorManager {
  static let shared: ActivityIndicatorManager = {
    let instance = ActivityIndicatorManager()
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setBackgroundLayerColor(UIColor.clear)
    SVProgressHUD.setBackgroundColor(UIColor.white)
    SVProgressHUD.setForegroundColor(UIColor.black)
    SVProgressHUD.setRingThickness(3.0)
    SVProgressHUD.setRingRadius(6.0)
    return instance
  }()
  
  func show() {
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show()
  }
  
  func dismiss() {
    SVProgressHUD.dismiss()
  }
}
