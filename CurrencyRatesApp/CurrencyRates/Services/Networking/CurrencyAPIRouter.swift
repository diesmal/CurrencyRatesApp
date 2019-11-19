//
//  CurrencyAPIRouter.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 12.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

enum CurrencyAPIRouter {
  case currencyPairRate
  
  static let base = "https://europe-west1-revolut-230009.cloudfunctions.net"
  
  var method: HTTPMethod {
    switch self {
    case .currencyPairRate:
      return .post
    }
  }
  
  var path: String {
    switch self {
    case .currencyPairRate:
      return "revolut-ios"
    }
  }
  
  func request(_ parameters: String? = nil) -> NetworkRequest {
    var fullPath = "\(CurrencyAPIRouter.base)/\(path)"
    var data: Data? = nil
    
    if let parameters = parameters {
      switch method {
      case .get:
        fullPath.append("?\(parameters)")
      case .post:
        data = parameters.data(using: .utf8)
      }
    }
    return NetworkRequest(path: fullPath, body: data, method: method)
  }
}
