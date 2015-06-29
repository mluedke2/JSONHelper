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
  let testIntAndResult = (1, "1")

  func testStringToStringConversion() {
    var value: String?
    value <-- (testString as Any)
    XCTAssertEqual(value!, testString, "String to String conversion failed")
  }

  func testIntToStringConversion() {
    var value: String?
    value <-- (testIntAndResult.0 as Any)
    XCTAssertEqual(value!, testIntAndResult.1, "Int to String conversion failed")
  }
}
