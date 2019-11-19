//
//  Logger.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 12.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class Logger {
  
  static func error(_ text: String) {
    print("🔴 \(Date()): \(text)")
  }
  
  static func error(_ error: Error) {
    print("🔴 \(Date()): \(error)")
   }
  
  static func warning(_ text: String) {
    print("🟡 \(Date()): \(text)")
  }
  
  static func info(_ text: String) {
    print("⚪️ \(Date()): \(text)")
  }
}
