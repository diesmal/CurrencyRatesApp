  //
  //  Currency.swift
  //  CurrencyRatesApp
  //
  //  Created by Ilia Nikolaenko on 02.11.19.
  //  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
  //
  
import Foundation

struct Currency  {
  let bankCode: String
  let name: String
  var iconName: String { return bankCode }
}
  
