//
//  CurrencyChooserCoordinator.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class CurrencyChooserCoordinator: CurrencyChooserPresenter {
  let storyboard: UIStoryboard = UIStoryboard(name: "CurrencyRates", bundle: Bundle.main)
  let currencyService: CurrenciesService
  let currencyPairsService: CurrencyPairsService
  var navController: UINavigationController?
  
  
  init(currencyService: CurrenciesService, currencyPairsService: CurrencyPairsService) {
    self.currencyService = currencyService
    self.currencyPairsService = currencyPairsService
  }
  
  func start(on topViewController: UIViewController, with completion: @escaping (Currency?, Currency?) -> Void) {
    let viewController = currenciesController(viewModel: nil, completion: completion)
    let navController = UINavigationController(rootViewController: viewController)
    navController.setNavigationBarHidden(true, animated: false)
    topViewController.present(navController, animated: true, completion: nil)
    self.navController = navController
  }
  
  func stop() {
    guard let navController = navController else {
      return
    }
    navController.dismiss(animated: true, completion: nil)
    self.navController = nil
  }
  
  func currenciesController(viewModel: CurrenciesViewModel? = nil, completion: @escaping ((Currency?, Currency?) -> Void)) -> UIViewController {
    let viewController = CurrenciesTableViewController.instantiate(from: storyboard)
    let viewModel = viewModel ?? CurrenciesViewModel(currenciesService: currencyService, currencyPairsService: currencyPairsService, completion: completion)
    viewModel.delegate = self
    viewController.viewModel = viewModel
    
    return viewController
  }
  
  func showCurrencyChooser(viewModel: CurrenciesViewModel?, completion: @escaping (Currency?, Currency?) -> Void) {
    guard let navController = navController else {
      return
    }
    let viewController = currenciesController(viewModel: viewModel, completion: completion)
    navController.pushViewController(viewController, animated: true)
  }
  
  func closeCurrencyChooser() {
    stop()
  }
}
