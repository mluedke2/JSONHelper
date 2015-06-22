//
//  StringTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 6/22/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class StringTests: XCTestCase {
  let testString = "test"
  let testInt = 1

  func testStringToStringConversion() {
    var value: String?
    value <-- (testString as Any)
    XCTAssertEqual(value!, testString, "String value to string deserialization failed")
  }

  func testIntToStringConversion() {
    var value: String?
    value <-- (testInt as Any)
    XCTAssertEqual(value!, "\(testInt)", "Int value to string deserialization failed")
  }
}
