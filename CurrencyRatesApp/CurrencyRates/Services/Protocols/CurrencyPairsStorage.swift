//
//  CurrencyPairsStorage.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol CurrencyPairsStorage {
  var pairs: [String] { get }
  
  func addPair(_ pair: String) throws
  func removePair(_ pair: String)
}
