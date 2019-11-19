//
//  CurrencyPairTableViewCell.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 03.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class CurrencyPairTableViewCell: UITableViewCell, Identifiable {
  
  @IBOutlet var leftTitle: UILabel!
  @IBOutlet var leftSubtitle: UILabel!
  @IBOutlet var rightSubtitle: UILabel!

  // There could be one label with attributed text, but two labels are simpler and faster
  @IBOutlet var rightTitle: UILabel!
  @IBOutlet var rightAdditionalTitle: UILabel!

  // Creating a view model for such a simple cell is unnecessary. But it makes sense if the cell gets harder.
  func setup(with model: CurrencyPair?) {
    guard let model = model else {
      return
    }
    leftTitle.text = "\(model.first.bankCode)"
    leftSubtitle.text = model.first.name
    rightTitle.text = model.rate.fractionDigits(min: 2, max: 2, roundingMode: .down)
    rightAdditionalTitle.text = model.rate.digits(at: -4, count: 2)
    rightSubtitle.text = "\(model.last.name) · \(model.last.bankCode)"
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    leftTitle.text = nil
    leftSubtitle.text = nil
    rightTitle.text = nil
    rightAdditionalTitle.text = nil
    rightSubtitle.text = nil
  }
  
}
