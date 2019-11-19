//
//  Formatter.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

extension Formatter {
  static let number = NumberFormatter()
}

extension FloatingPoint {
  
  func fractionDigits(min: Int = 2, max: Int = 2, roundingMode: NumberFormatter.RoundingMode = .down) -> String {
    Formatter.number.minimumFractionDigits = min
    Formatter.number.maximumFractionDigits = max
    Formatter.number.roundingMode = roundingMode
    Formatter.number.numberStyle = .decimal
    
    return Formatter.number.string(for: self) ?? ""
  }
}

extension Double {
  
  func digits(at position: Int, count: Int) -> String {
    let shift = pow(10.0, Double(position))
    let modulo = pow(10.0, Double(count))
    let number = (self / shift).truncatingRemainder(dividingBy: modulo)
    
    return String(format: "%.\(count)d", Int(number))
  }
}
