//
//  CurrenciesViewController.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class CurrenciesViewModel {
  let currencies: CurrenciesService
  let currencyPairs: CurrencyPairsService
  let completion: (Currency?, Currency?) -> Void
  var selectedCurrency: Currency?
  var currenciesCount: Int { currencies.count }
  weak var delegate: CurrencyChooserPresenter? = nil
  
  
  init(currenciesService: CurrenciesService, currencyPairsService: CurrencyPairsService, completion: @escaping (Currency?, Currency?) -> Void) {
    self.completion = completion
    currencies = currenciesService
    currencyPairs = currencyPairsService
  }
  
  func currency(at index: Int) -> Currency {
    return currencies[index]
  }
  
  func isAvaliable(at index: Int) -> Bool {
    let currencyCode = currency(at: index).bankCode
    
    if let selectedBankCode = selectedCurrency?.bankCode {
      if selectedCurrency?.bankCode ?? "" == currencyCode {
        return false
      }
      let pairCode = "\(selectedBankCode)\(currencyCode)"
      return currencyPairs.pairs[pairCode] == nil
    }
    
    var it = currencies.makeIterator()
    while let currency = it.next() {
      if currencyCode == currency.bankCode {
        continue
      }
      let pairCode = "\(currencyCode)\(currency.bankCode)"
      if currencyPairs.pairs[pairCode] == nil {
        return true
      }
    }
    return false
  }
  
  func didSelect(at index: Int) {
    if let first = selectedCurrency {
      let last = currency(at: index)
      completion(first, last)
      delegate?.closeCurrencyChooser()
    } else {
      selectedCurrency = currency(at: index)
      delegate?.showCurrencyChooser(viewModel: self, completion: completion)
    }
  }
}
