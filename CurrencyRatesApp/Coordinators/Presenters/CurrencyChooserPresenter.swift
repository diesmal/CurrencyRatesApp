//
//  CurrencyChooserPresenter.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol CurrencyChooserPresenter: class {
  func showCurrencyChooser(viewModel: CurrenciesViewModel?, completion: @escaping (Currency?, Currency?) -> Void)
  func closeCurrencyChooser()
}
