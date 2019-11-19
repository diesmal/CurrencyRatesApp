//
//  Network.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol Network {
  func processRequest<EntityType: Decodable>(_ request: NetworkRequest, with completion: @escaping (Result<EntityType, Error>) -> Void)
}
