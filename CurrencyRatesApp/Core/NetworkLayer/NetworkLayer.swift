//
//  NetworkLayer.swift
//  DeezerService
//
//  Created by Ilia Nikolaenko on 14.07.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class NetworkLayer: Network {
  
  enum _Error: Error {
    case cannotParse
  }
  
  private let httpLayer: HTTPLayer
  private let decoder: JSONDecoder
  
  
  init(httpLayer: HTTPLayer = HTTPLayer(), decoder: JSONDecoder = JSONDecoder()) {
    self.httpLayer = httpLayer
    self.decoder = decoder
  }
  
  func processRequest<EntityType: Decodable>(_ request: NetworkRequest, with completion: @escaping (Result<EntityType, Error>) -> Void) {
    httpLayer.request(at: request.path, method: request.method, httpBody: request.body) { [weak self] (result) in
      switch result {
      case .success(let data):
        if let parsedData = self?.parseData(data, type: EntityType.self) {
          completion(.success(parsedData))
        } else {
          Logger.error("network failure response: \(String(data: data, encoding: .utf8) ?? ""))")
          completion(.failure(_Error.cannotParse))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func parseData<EntityType: Decodable>(_ data: Data,  type: EntityType.Type) -> EntityType? {
    guard type != Data.self else {
      return data as? EntityType
    }
    
    var entity: EntityType? = nil
    do {
      entity = try decoder.decode(EntityType.self, from: data)
    } catch {
      Logger.error(error)
    }
    return entity
  }
  
}
