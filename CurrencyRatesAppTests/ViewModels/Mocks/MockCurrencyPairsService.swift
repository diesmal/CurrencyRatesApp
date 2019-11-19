//
//  MockCurrencyPairsService.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class MockCurrencyPairsService: CurrencyPairsService {
  var count: Int
  var isAddedAllPairs: Bool
  var pairs: [String : CurrencyPair]
  
  func updateRates(with completion: @escaping (Result<Bool, Error>) -> Void) {}
  func add(_ pair: CurrencyPair) {}
  func remove(_ pair: CurrencyPair) {}
  
  subscript(index: Int) -> CurrencyPair? { nil }
  
  init (count: Int = 0, isAddedAllPairs: Bool = false, pairs: [String : CurrencyPair] = [:]) {
    self.count = count
    self.isAddedAllPairs = isAddedAllPairs
    self.pairs = pairs
  }
}

