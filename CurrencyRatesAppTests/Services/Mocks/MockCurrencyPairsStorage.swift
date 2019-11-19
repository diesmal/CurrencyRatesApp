//
//  MockCurrencyPairsStorage.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class MockCurrencyPairsStorage: CurrencyPairsStorage {  
  var pairs: [String]
  
  func addPair(_ pair: String) throws {
    pairs.append(pair)
  }
  
  func removePair(_ pair: String) {
    if let index = pairs.firstIndex(of: pair) {
      pairs.remove(at: index)
    }
  }
  
  init(pairs: [String] = []) {
    self.pairs = pairs
  }
  
}
