//
//  JSONHelper.swift
//
//  Created by Baris Sencan on 28/08/2014.
//  Copyright 2014 Baris Sencan
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://github.com/isair/JSONHelper
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import Foundation

/// A type of dictionary that only uses strings for keys and can contain any
/// type of object as a value.
public typealias JSONDictionary = [String: AnyObject]

/// An object that can attempt to convert values of unknown types to its own type.
public protocol Convertible {

  /// TODOC
  static func convertFromValue(value: Any?) -> Self?
}

/// Filters out values of type NSNull.
///
/// :param: value Value to check.
///
/// :returns: nil if value is of type NSNull, else the value is returned as-is.
public func convertToNilIfNull(value: Any?) -> Any? {
  if value is NSNull {
    return nil
  }
  return value
}

/// TODOC
public protocol Deserializable {

  /// TODOC
  init(jsonDictionary: JSONDictionary)
}

/// TODOC
public protocol Serializable {

  /// TODOC
  func toJSONDictionary() -> JSONDictionary
}

/// Operator for use in right hand side to left hand side conversion and deserialization.
infix operator <-- { associativity right precedence 150 }

public func <-- <C: Convertible, T>(inout lhs: C?, rhs: T?) -> C? {
  lhs = C.convertFromValue(convertToNilIfNull(rhs))
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: C, rhs: T?) -> C {
  var newValue: C?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [C]?, rhs: T?) -> [C]? {
  if let array = rhs as? [AnyObject] {
    lhs = [C]()
    for element in array {
      var convertedElement: C?
      convertedElement <-- element
      if let convertedElement = convertedElement {
        lhs?.append(convertedElement)
      }
    }
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [C], rhs: T?) -> [C] {
  var newValue: [C]?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [String: C]?, rhs: T?) -> [String: C]? {
  if let dictionary = rhs as? JSONDictionary {
    lhs = [String: C]()
    for (key, value) in dictionary {
      var convertedValue: C?
      convertedValue <-- value
      if let convertedValue = convertedValue {
        lhs?[key] = convertedValue
      }
    }
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [String: C], rhs: T?) -> [String: C] {
  var newValue: [String: C]?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: D?, rhs: T?) -> D? {
  let cleanedValue = convertToNilIfNull(rhs)
  if let jsonDictionary = cleanedValue as? JSONDictionary {
    lhs = D(jsonDictionary: jsonDictionary)
  } else if let
    jsonString = cleanedValue as? String,
    jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
      lhs <-- NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(0), error: nil)
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: D, rhs: T?) -> D {
  var newValue: D?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: [D]?, rhs: T?) -> [D]? {
  if let array = rhs as? [AnyObject] {
    lhs = [D]()
    for element in array {
      var convertedElement: D?
      convertedElement <-- element
      if let convertedElement = convertedElement {
        lhs?.append(convertedElement)
      }
    }
  } else if let
    jsonString = convertToNilIfNull(rhs) as? String,
    jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
      lhs <-- NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(0), error: nil)
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: [D], rhs: T?) -> [D] {
  var newValue: [D]?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

/// Operator for use in left hand side to right hand side conversion and serialization.
infix operator --> { associativity left precedence 150 }

public func --> <C: Convertible>(lhs: Any?, inout rhs: C?) -> C? {
  return rhs <-- lhs
}

public func --> <C: Convertible>(lhs: Any?, inout rhs: C) -> C {
  return rhs <-- lhs
}

public func --> <C: Convertible>(lhs: AnyObject?, inout rhs: [C]?) -> [C]? {
  return rhs <-- lhs
}

public func --> <C: Convertible>(lhs: AnyObject?, inout rhs: [C]) -> [C] {
  return rhs <-- lhs
}

// TODO: Serialization
