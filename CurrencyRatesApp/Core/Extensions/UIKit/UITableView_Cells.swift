//
//  UITablleView+CellId.swift
//  LastAlbums
//
//  Created by Ilia Nikolaenko on 11.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

extension UITableView {

  func dequeue<CellType: UITableViewCell &  Identifiable>(_: CellType.Type, for indexPath: IndexPath) -> CellType {
    guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
      fatalError("Could not deque table cell with type \(CellType.self)")
    }
    return cell
  }
}
