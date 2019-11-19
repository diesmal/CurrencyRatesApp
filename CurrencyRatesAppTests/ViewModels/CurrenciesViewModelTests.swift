//
//  CurrenciesViewModelTests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class CurrenciesViewModelTests: XCTestCase {
  
  func testIfPairPossibleThenItsAvalaibale() {
    let viewModel = currenciesViewModel()
    viewModel.selectedCurrency = nil
    XCTAssertTrue(viewModel.isAvaliable(at: 0))
  }
  
  func testIfPairNotAddedThenItsAvalaibale() {
    let viewModel = currenciesViewModel()
    viewModel.selectedCurrency = Currency(bankCode: "EUR", name: "")
    XCTAssertTrue(viewModel.isAvaliable(at: 0))
  }
  
  func testIfPairWithSameCurrencyThenItsNotAvalaibale() {
    let viewModel = currenciesViewModel()
    viewModel.selectedCurrency = Currency(bankCode: "GBP", name: "")
    XCTAssertFalse(viewModel.isAvaliable(at: 0))
  }
  
  func testIfPairAddedThenItsNotAvalaibale() {
    let viewModel = currenciesViewModel()
    viewModel.selectedCurrency = Currency(bankCode: "GBP", name: "")
    XCTAssertFalse(viewModel.isAvaliable(at: 1))
  }
  
  func testIfPairNotPossibleItsNotAvalaibale() {
    let viewModel = currenciesViewModel()
    viewModel.selectedCurrency = nil
    XCTAssertFalse(viewModel.isAvaliable(at: 2))
  }
  
  //MARK: Helpers
  
  func currenciesViewModel() -> CurrenciesViewModel {
    let currencies = [Currency(bankCode: "GBP", name: "") ,
                      Currency(bankCode: "EUR", name: ""),
                      Currency(bankCode: "USD", name: "")]
    let pairs = ["GBPEUR" : CurrencyPair(first: currencies[0], last: currencies[1], rate: 0),
                 "USDGBP" : CurrencyPair(first: currencies[2], last: currencies[0], rate: 0),
                 "USDEUR" : CurrencyPair(first: currencies[2], last: currencies[1], rate: 0)]
    
    let currenciesService = MockCurrenciesService(orderedCurrencies: currencies)
    let currencyPairsService = MockCurrencyPairsService(pairs: pairs)
    
    let viewModel = CurrenciesViewModel(currenciesService: currenciesService, currencyPairsService: currencyPairsService) { (_, _) in }
    
    return viewModel
  }
}
