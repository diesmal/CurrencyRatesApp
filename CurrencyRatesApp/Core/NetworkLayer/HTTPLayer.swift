//
//  HTTPLayer.swift
//  DeezerService
//
//  Created by Ilia Nikolaenko on 14.07.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class HTTPLayer {
  
  enum _Error: Error {
    case badURL
    case badResponse(URLResponse)
    case noResponseData
  }
  
  let session: URLSession
  
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func request(at path: String, method: HTTPMethod = .get, httpBody: Data? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string: path) else {
      completion(.failure(_Error.badURL))
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = httpBody
    
    let task = session.dataTask(with: request) { [weak self] (data, response, error) in
      if let data = data {
        completion(.success(data))
      } else if let error = error {
        completion(.failure(error))
      } else if let response = response {
        self?.checkReponse(response, completion: completion)
      } else {
        completion(.failure(_Error.noResponseData))
      }
    }
    
    task.resume()
  }
  
  func checkReponse(_ response: URLResponse, completion: (Result<Data, Error>) -> Void) {
    guard let httpResponse = response as? HTTPURLResponse else {
      completion(.failure(_Error.badResponse(response)))
      return
    }
    if httpResponse.statusCode == 200 {
      completion(.success(Data()))
    } else {
      completion(.failure(_Error.badResponse(response)))
    }
  }
}
