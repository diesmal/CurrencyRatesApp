//
//  CurrencyTableViewCell.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 02.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell, Identifiable {
  
  @IBOutlet var icon: UIImageView!
  @IBOutlet var bankCode: UILabel!
  @IBOutlet var name: UILabel!
  
  func setup(with model: Currency?) {
    guard let model = model else {
      return
    }
    name.text = model.name
    bankCode.text = model.bankCode
    icon.image = UIImage(named: model.iconName)
  }
  
  var disable: Bool! {
    didSet {
      name.alpha = disable ? 0.5 : 1
      bankCode.alpha = disable ? 0.5 : 1
      icon.alpha = disable ? 0.5 : 1
      
      isUserInteractionEnabled = !disable
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    selectedBackgroundView = UIView()
    selectedBackgroundView?.backgroundColor = CurrencyColor.selectedRow.value
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    icon.layer.shadowRadius = 1
    icon.layer.shadowOffset = CGSize.zero
    icon.layer.shadowOpacity = 0.5
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    name.text = nil
    bankCode.text = nil
    icon.image = nil
  }
}
