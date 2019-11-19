//
//  CurrencyColors.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 03.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

enum CurrencyColor: String {
  
  case selectedRow = "CurrencySelectedRow"
  
  var value: UIColor? {
    return UIColor(named: self.rawValue)
  }
}
