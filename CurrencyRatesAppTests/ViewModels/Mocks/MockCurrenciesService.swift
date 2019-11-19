//
//  MockCurrenciesService.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class MockCurrenciesService: CurrenciesService {
  var count: Int
  var orderedCurrencies: [Currency]
  let currencies: [String : Currency]
  
  subscript(index: Int) -> Currency { orderedCurrencies[index] }
  
  subscript(bankCode: String) -> Currency? { currencies[bankCode] }
  
  func makeIterator() -> Array<Currency>.Iterator {
    orderedCurrencies.makeIterator()
  }
  
  init (count: Int = 0, currencies: [String : Currency] = [:], orderedCurrencies: [Currency] = []) {
    self.count = count
    self.currencies = currencies
    self.orderedCurrencies = orderedCurrencies
  }
}
