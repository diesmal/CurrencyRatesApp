//
//  MockNetwork.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class MockNetwork: Network {
  var proccess: ((_ request: NetworkRequest) -> Void)? = nil
  
  func processRequest<EntityType>(_ request: NetworkRequest, with completion: @escaping (Result<EntityType, Error>) -> Void) where EntityType: Decodable {
    if let proccess = proccess {
      proccess(request)
    }
  }
}
