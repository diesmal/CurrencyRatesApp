//
//  CurrencyPairsStorageImpTests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class CurrencyPairsStorageImpTests: XCTestCase {
  
  let storageKey = "CurrencyPairsStorage_UserCurrencyPairs"
  var userDefaults: UserDefaults!
  var storage: CurrencyPairsStorageImp!
  
  override func setUp() {
    userDefaults = UserDefaults()
    userDefaults.set(["EURUSD"], forKey: storageKey)
    storage = CurrencyPairsStorageImp(storage: userDefaults)
  }
  
  func testIfCurrencyPairHasWrongCodeThenItNotAdded() {
    try? storage.addPair("EUR")
    XCTAssertEqual(storage.pairs, ["EURUSD"])
  }
  
  func testIfCurrencyWasAddedThenItNotAdded() {
    try? storage.addPair("EURUSD")
    XCTAssertEqual(storage.pairs, ["EURUSD"])
  }
  
  func testIfCurrencyWasNotAddedThenItAdded() {
    try? storage.addPair("USDEUR")
    XCTAssertEqual(storage.pairs, ["EURUSD", "USDEUR"])
  }

  func testIfExistCurrencyWasRemovedThenItRemoved() {
    storage.removePair("EURUSD")
    XCTAssertEqual(storage.pairs, [])
  }
  
  func testIfPairsAddedThenUserDefaultUpdated() {
    try? storage.addPair("USDEUR")
    XCTAssertEqual(userDefaults.array(forKey: storageKey) as! [String], ["EURUSD", "USDEUR"])
  }
  
  func testIfPairsRemovedThenUserDefaultUpdated() {
    storage.removePair("EURUSD")
    XCTAssertEqual(userDefaults.array(forKey: storageKey) as! [String], [])
  }
  
}
