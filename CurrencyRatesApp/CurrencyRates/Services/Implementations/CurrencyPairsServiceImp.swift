//
//  CurrencyPairsServiceImp.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 13.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class CurrencyPairsServiceImp: CurrencyPairsService {
  let network: CurrencyAPI
  let currencies: CurrenciesService
  let storage: CurrencyPairsStorage
  var count: Int { pairs.count }
  var isAddedAllPairs: Bool { count == currencies.count * (currencies.count - 1) }
  
  lazy var pairs: [String : CurrencyPair] = {
    var pairs = [String : CurrencyPair]()
    for pair in storage.pairs {
      let first = String(pair.prefix(3))
      let last = String(pair.suffix(3))
      
      if let firstCurrency = currencies[first],
        let lastCurrency = currencies[last]  {
        pairs[pair] = CurrencyPair(first: firstCurrency, last: lastCurrency, rate: 0)
      } else {
        Logger.error("missing currency pair \(pair)")
      }
    }
    return pairs
  }()
  
  
  init(network: Network, storage: CurrencyPairsStorage, currenciesService: CurrenciesService) {
    self.network = CurrencyAPI(network: network)
    self.storage = storage
    currencies = currenciesService
  }
  
  func updateRates(with completion: @escaping (Result<Bool, Error>) -> Void) {
    guard storage.pairs.count > 0 else {
      completion(.success(false))
      return
    }
    network.updateRates(for: storage.pairs) { [weak self] (response) in
      switch response {
      case .success(let result):
        DispatchQueue.main.async {
          self?.applyRates(result)
        }
        completion(.success(true))
      case .failure(let error):
        completion(.failure(error))
        Logger.error(error)
      }
    }
  }
  
  func applyRates(_ rates: [String : Double]) {
    for  (key, value) in rates {
      self.pairs[key]?.rate = value
    }
  }
  
  subscript(index: Int) -> CurrencyPair? {
    guard index < storage.pairs.count else {
      Logger.error("Index: \(index) is out of bound for currency pairs: \(storage.pairs)")
      return nil
    }
    return pairs[storage.pairs[index]]
  }
  
  func add(_ pair: CurrencyPair) {
    let pairCode = "\(pair.first.bankCode)\(pair.last.bankCode)"
    do {
      try storage.addPair(pairCode)
      pairs[pairCode] = pair
    } catch {
      Logger.error(error)
    }
  }
  
  func remove(_ pair: CurrencyPair) {
    let pairCode = "\(pair.first.bankCode)\(pair.last.bankCode)"
    storage.removePair(pairCode)
    pairs[pairCode] = nil
  }
}


