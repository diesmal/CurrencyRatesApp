//
//  CurrenciesService.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol CurrenciesService {
  var count: Int { get }
  
  subscript(index: Int) -> Currency { get }
  subscript(bankCode: String) -> Currency? { get }
  
  func makeIterator() -> Array<Currency>.Iterator
}
