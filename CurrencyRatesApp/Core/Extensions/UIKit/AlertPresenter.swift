//
//  AlertPresenter.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 16.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

protocol AlertPresenter {
  func showAlert(title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)?)
}

extension AlertPresenter where Self: UIViewController {

  func showAlert(title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: handler))
      present(alert, animated: true, completion: nil)
  }
}
