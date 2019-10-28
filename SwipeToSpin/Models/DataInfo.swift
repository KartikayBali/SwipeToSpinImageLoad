//
//  DataInfo.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

class DataInfo {
  
  var images = [Image]()
  var currentOffset = -1
  var nextOffset = 0
  var totalCount = 0
  
  init(data: [String: Any]? = nil) {
  }
  
//  convenience init(data: [String: Any]) {
////    self.init()
//    updateInfo(data: data)
//  }
  
  func updateInfo(data: [String: Any]) {
    if let value = data["totalEstimatedMatches"] as? Int {
      totalCount = value
    }
    
    if let value = data["nextOffset"] as? Int {
      nextOffset = value
    }
    
    if let value = data["currentOffset"] as? Int {
      currentOffset = value
    }
    
    if let jsonD = data["value"] as? [Dictionary<String, Any>] {
      for data in jsonD {
        let image = Image(data: data)
        images.append(image)
      }
    }
  }
}
