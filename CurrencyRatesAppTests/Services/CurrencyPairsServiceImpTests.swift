//
//  CurrencyPairsServiceImpTests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class CurrencyPairsServiceImpTests: XCTestCase {
  
  let storedPairs = ["EURUSD", "USDEUR"]
  
  func testIfStoredPairsCorrectThenPairsCreated() {
    let service = currencyPairsService()
    let expectedResult = Set(storedPairs)
    let result = Set(service.pairs.values.map({"\($0.first.bankCode)\($0.last.bankCode)"}))
    
    XCTAssertEqual(result, expectedResult)
  }
  
  func testRatesUpdate() {
    let newRates = ["EURUSD" : 1.1, "USDEUR" : 2.2]
    let service = currencyPairsService()
    service.applyRates(newRates)
    
    let expectedResult = Set(newRates.keys.map({ "\($0)\(newRates[$0]!)" }) )
    let result = Set(service.pairs.values.map({ "\($0.first.bankCode)\($0.last.bankCode)\($0.rate)" }))
    
    XCTAssertEqual(result, expectedResult)
  }
  
  //MARK: Helpers
  
  func currencyPairsService() -> CurrencyPairsServiceImp {
    let storage = MockCurrencyPairsStorage(pairs: storedPairs)
    let eurCurrency = Currency(bankCode: "EUR", name: "")
    let usdCurrency = Currency(bankCode: "USD", name: "")
    let currenciesService = MockCurrenciesService(currencies: ["EUR": eurCurrency, "USD": usdCurrency])
    let currencyPairsService =  CurrencyPairsServiceImp(network: MockNetwork(),
                                                        storage: storage,
                                                        currenciesService: currenciesService)
    return currencyPairsService
  }
}
