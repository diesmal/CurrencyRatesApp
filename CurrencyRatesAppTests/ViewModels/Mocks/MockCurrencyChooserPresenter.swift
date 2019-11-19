//
//  MockCurrencyChooserPresenter.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class MockCurrencyChooserPresenter: CurrencyChooserPresenter {
  var isCurrencyChooserPresented = false
  func showCurrencyChooser(viewModel: CurrenciesViewModel?, completion: @escaping (Currency?, Currency?) -> Void) {
    isCurrencyChooserPresented = true
  }
  
  func closeCurrencyChooser() {}
}
