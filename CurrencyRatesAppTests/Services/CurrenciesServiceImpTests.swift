//
//  CurrenciesServiceImpTests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class CurrenciesServiceImpTests: XCTestCase {

  func testIfCurrencyJSONCorrectThenItParsed() {
    let service = CurrenciesServiceImp()
    let expectedKeys = Set(["EUR", "GBP", "ILS", "INR", "RUB", "USD"])
    let keys = Set(service.currencies.keys)
    
    XCTAssertEqual(expectedKeys, keys)
  }

  func testCurrencyOrder() {
    let service = CurrenciesServiceImp()
    let expectedOrder = ["GBP", "EUR", "USD", "ILS", "INR", "RUB"]
    let result = service.orderedCurrencies.map({ $0.bankCode })
    
    XCTAssertEqual(result, expectedOrder)
  }
}
