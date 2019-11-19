//
//  CurrencyPairsService.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol CurrencyPairsService {
  var count: Int { get }
  var isAddedAllPairs: Bool { get }
  var pairs: [String : CurrencyPair] { get }
  
  subscript(index: Int) -> CurrencyPair? { get }
  
  func updateRates(with completion: @escaping (Result<Bool, Error>) -> Void)
  func add(_ pair: CurrencyPair)
  func remove(_ pair: CurrencyPair)
}
