//
//  CurrencyAPI.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 12.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

final class CurrencyAPI {
  private let network: Network

  init(network: Network) {
    self.network = network
  }
  
  func updateRates(for pairs: [String], completion: @escaping (Result<Dictionary<String, Double>, Error>) -> Void) {
    let parametes = "pairs=" + pairs.joined(separator: "&pairs=")
    let request = CurrencyAPIRouter.currencyPairRate.request(parametes)
    
    self.network.processRequest(request, with: completion)
  }
}
