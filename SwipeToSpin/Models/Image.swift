//
//  Image.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

class Image {
  
  var url = ""
  var thumbnail = ""
  var name = ""
  
  init(data: [String: Any]) {
    if let name = data["name"] as? String {
      self.name = name
    }
    
    if let url = data["contentUrl"] as? String {
      self.url = url
    }
    
    if let thumbnail = data["thumbnailUrl"] as? String {
      self.thumbnail = thumbnail
    }
  }
}
