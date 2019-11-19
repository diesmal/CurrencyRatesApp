//
//  CurrencyPairsViewModelTests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class CurrencyPairsViewModelTests: XCTestCase {
  
  func testIfAllPairsAddedThenCurrencyChooserNotPresented() {
    let viewModel = CurrencyPairsViewModel(service: MockCurrencyPairsService(isAddedAllPairs: true))
    let delegate = MockCurrencyChooserPresenter()
    viewModel.delegate = delegate
    viewModel.addPairTriggered()
    
    XCTAssertFalse(delegate.isCurrencyChooserPresented)
  }

  func testIfAllPairsNotAddedThenCurrencyChooserIsPresented() {
    let viewModel = CurrencyPairsViewModel(service: MockCurrencyPairsService(isAddedAllPairs: false))
    let delegate = MockCurrencyChooserPresenter()
    viewModel.delegate = delegate
    viewModel.addPairTriggered()
    
    XCTAssertTrue(delegate.isCurrencyChooserPresented)
  }
}
