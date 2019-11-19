//
//  CurrenciesServiceImp.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class CurrenciesServiceImp: CurrenciesService {
  let currencyCodePriority = ["GBP", "EUR", "USD"]
  let currencies: [String : Currency]
  var count: Int { orderedCurrencies.count }
  lazy var orderedCurrencies: [Currency] = {
    currencies
      .map({ $1 })
      .sorted { (left, right) -> Bool in
      for code in currencyCodePriority {
        if left.bankCode == code {
          return true
        }
        if right.bankCode == code {
          return false
        }
      }
      return left.bankCode < right.bankCode
    }
  }()
  
  subscript(index: Int) -> Currency {
    orderedCurrencies[index]
  }
  
  subscript(bankCode: String) -> Currency? {
    currencies[bankCode]
  }
  
  init() {
    guard let jsonFileURL = Bundle(for: type(of: self)).url(forResource: "currencies", withExtension: "json") else {
      fatalError("missing currencies.json file")
    }
    
    var currencies = [String : Currency]()
    do {
      let data = try Data(contentsOf: jsonFileURL)
      let decoded = try JSONDecoder().decode([String : String].self, from: data)
      for  (key, value) in decoded {
        currencies[key] = Currency(bankCode: key, name: value)
      }
    } catch {
      fatalError("can't read currencies.json file: \(error)")
    }
    self.currencies = currencies
  }
  
  func makeIterator() -> Array<Currency>.Iterator {
    orderedCurrencies.makeIterator()
   }
}
