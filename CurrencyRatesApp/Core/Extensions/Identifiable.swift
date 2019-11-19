//
//  IdentificationProvider.swift
//  LastAlbums
//
//  Created by Ilia Nikolaenko on 11.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable  {
  static var identifier: String {
    return String(describing: self)
  }
}
