//
//  APIManager.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
  static let baseURL = (Bundle.main.object(forInfoDictionaryKey: "Base URL") as! String)
  static let apiPrefix = "/bing/v7.0/"
  static let URL = "\(baseURL)\(apiPrefix)"
  static let authorizationHeader="Ocp-Apim-Subscription-Key"
  
  class var getHeaders: HTTPHeaders? {
    var header: HTTPHeaders = ["Content-Type": "application/json"]
    header[authorizationHeader] = (Bundle.main.object(forInfoDictionaryKey: "Azure Key") as! String)
    
    return header
  }
//  class func getHeaders() -> HTTPHeaders? {
//    
//  }
  
  class func fetchImagesForSearchText(_ text: String, count: Int, nextOffset: Int, callBack: @escaping (_ result: DataInfo?, _ error: String?) -> Void) {
    guard let headers = getHeaders else {
      return
    }
    
    let params: [String: Any] = ["q": text, "count": count, "offset": nextOffset]
    Alamofire.request(URL + "images/search", method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
      
      if let jsonD = response.result.value as? Dictionary<String, Any> {
        let dataInfo = DataInfo(data: jsonD)
        callBack(dataInfo, nil)
      } else {
        callBack(nil, response.error?.localizedDescription ?? "Error")
      }
    }
  }
}
