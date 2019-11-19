//
//  CurrencyPairsStorage.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 14.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class CurrencyPairsStorageImp: CurrencyPairsStorage {
  
  enum _Error: Error {
    case wrongPairCode(String)
    case alreadyExist(String)
  }
  
  let storage: UserDefaults
  let storageKey = "CurrencyPairsStorage_UserCurrencyPairs"
  
  var pairs: [String] {
    willSet(newValue) {
      storage.set(newValue, forKey: storageKey)
      storage.synchronize()
    }
  }
  
  
  init(storage: UserDefaults = UserDefaults.standard) {
    self.storage = storage
    pairs = storage.array(forKey: storageKey) as? [String] ?? []
  }
  
  func addPair(_ pair: String) throws {
    guard pair.count == 6 else {
      throw _Error.wrongPairCode(pair)
    }
    guard !pairs.contains(pair) else {      
      throw _Error.alreadyExist(pair)
    }
    pairs.append(pair)
  }
  
  func removePair(_ pair: String) {
    if let index = pairs.firstIndex(of: pair) {
      pairs.remove(at: index)
    } else {
      Logger.warning("Trying to delete an unsaved currency pair code: \(pair)")
    }
  }
  
}
