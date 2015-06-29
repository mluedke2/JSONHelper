//
//  BoolTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 6/29/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class BoolTests: XCTestCase {
  let testBool = true
  let testIntsAndResults = [(-1, false), (0, false), (1, true), (2, true)]
  let testString = "true"
  let testStringAlternative = "t"

  func testBoolToBoolConversion() {
    var value: Bool?
    value <-- (testBool as Any)
    XCTAssertEqual(value!, testBool, "Bool to Bool conversion failed")
  }

  func testIntToBoolConversion() {
    var value: Bool?
    for intAndResult in testIntsAndResults {
      value <-- (intAndResult.0 as Any)
      XCTAssertEqual(value!, intAndResult.1, "Int to Bool conversion failed for value \(intAndResult.0)")
    }
  }

  func testStringToBoolConversion() {
    var value: Bool?
    value <-- (testString as Any)
    XCTAssertEqual(value!, testBool, "String to Bool conversion failed")
  }

  func testAlternativeStringToBoolConversion() {
    var value: Bool?
    value <-- (testStringAlternative as Any)
    XCTAssertEqual(value!, testBool, "String to Bool conversion failed for alternative string representation")
  }
}
