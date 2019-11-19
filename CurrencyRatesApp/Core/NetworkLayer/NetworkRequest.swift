//
//  NetworkRequest.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

struct NetworkRequest {
  let path: String
  let body: Data?
  let method: HTTPMethod
}
