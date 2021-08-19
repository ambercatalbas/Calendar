//
//  Array+Equatable.swift
//  daynote
//
//  Created by Yasemin YEL on 9.08.2021.
//
//
import UIKit
import Foundation

extension Array where Element: Equatable {

  // Remove first collection element that is equal to the given `object`:
  mutating func remove(object: Element) {
      guard let index = firstIndex(of: object) else {return}
      remove(at: index)
  }

}
