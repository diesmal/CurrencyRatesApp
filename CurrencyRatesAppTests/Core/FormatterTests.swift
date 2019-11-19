//
//  FormatterTests.swift
//  CurrencyRatesAppTests
//
//  Created by Ilia Nikolaenko on 17.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class FormatterTests: XCTestCase {
  
  func testBigNumberFormatted() {
    XCTAssertEqual(123456789.123456789.fractionDigits(min: 2, max: 2, roundingMode: .down), "123,456,789.12")
  }
  
  func testSmallNumberFormatted() {
    XCTAssertEqual(1.fractionDigits(min: 2, max: 2, roundingMode: .down), "1.00")
  }
  func testZeroNumberFormatted() {
    XCTAssertEqual(0.fractionDigits(min: 4, max: 4, roundingMode: .down), "0.0000")
  }
  
  func testNoRoundingDuringFormatting() {
    XCTAssertEqual(1.999999.fractionDigits(min: 2, max: 2, roundingMode: .down), "1.99")
  }
  
  func testsDigitsInIntegerPart() {
    XCTAssertEqual(123456789.123456789.digits(at: 2, count: 3), "567")
  }
  
  func testsDigitsInFractionalPart() {
    XCTAssertEqual(123456789.123456789.digits(at: -4, count: 2), "34")
  }
  
  func testsDigitsInEmptyFractionalPart() {
    XCTAssertEqual(123456789.digits(at: -4, count: 4), "0000")
  }
  
  func testsDigitsInEmptyIntegerPart() {
    XCTAssertEqual(0.123456789.digits(at: 4, count: 4), "0000")
  }
}
