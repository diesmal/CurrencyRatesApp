//
//  CurrencyAPITests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class CurrencyAPITests: XCTestCase {

  func testUpdateRatesBodyIsCorrect() {
    let network = MockNetwork()
    let api = CurrencyAPI(network: network)
    
    var body: Data? = nil
    let expectedBody = "pairs=EURUSD&pairs=USDEUR".data(using: .utf8)
    
    network.proccess = { request in
      body = request.body
    }
    
    api.updateRates(for: ["EURUSD", "USDEUR"]) { (_) in }
    
    XCTAssertEqual(body!, expectedBody)
  }
}
