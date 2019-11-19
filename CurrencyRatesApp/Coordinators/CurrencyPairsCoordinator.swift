//
//  CurrencyRatesCoordinator.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class CurrencyPairsCoordinator {
  let window: UIWindow
  let storyboard: UIStoryboard = UIStoryboard(name: "CurrencyRates", bundle: Bundle.main)
  let currencyService: CurrenciesService  = CurrenciesServiceImp()
  let currencyStorage: CurrencyPairsStorage  = CurrencyPairsStorageImp()
  let currencyPairsService: CurrencyPairsService
  let currencyChooserCoordinator: CurrencyChooserCoordinator
  
  
  init(window: UIWindow, network: Network) {
    self.window = window
    currencyPairsService = CurrencyPairsServiceImp(network: network, storage: currencyStorage, currenciesService: currencyService)
    currencyChooserCoordinator = CurrencyChooserCoordinator(currencyService: currencyService, currencyPairsService: currencyPairsService)
  }
  
  func start() {
    window.rootViewController = pairsController()
  }
  
  func pairsController() -> UIViewController {
    let viewController = CurrencyPairsTableViewController.instantiate(from: storyboard)
    let viewModel = CurrencyPairsViewModel(service: currencyPairsService)
    viewModel.delegate = self
    viewController.viewModel = viewModel
    
    return viewController
  }
}


extension CurrencyPairsCoordinator: CurrencyChooserPresenter {
  func showCurrencyChooser(viewModel: CurrenciesViewModel?, completion: @escaping (Currency?, Currency?) -> Void) {
    guard let topViewController = window.rootViewController else {
      Logger.error("missing parent controller for present currency chooser")
      return
    }
    currencyChooserCoordinator.start(on: topViewController, with: completion)
  }
  func closeCurrencyChooser() {
    currencyChooserCoordinator.stop()
  }
}
