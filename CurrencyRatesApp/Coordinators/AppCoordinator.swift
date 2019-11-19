//
//  AppCoordinator.swift
//  LastAlbums
//
//  Created by Ilia Nikolaenko on 08.10.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class AppCoordinator {
  
  let network: Network = NetworkLayer()
  var currencyRatesCoordinator: CurrencyPairsCoordinator?
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    currencyRatesCoordinator = CurrencyPairsCoordinator(window: window, network: network)
    currencyRatesCoordinator?.start()
  }
}
