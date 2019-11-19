//
//  CurrencyPairsTableViewController.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 03.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit
import Combine

class CurrencyPairsTableViewController: UITableViewController, Combinable {
  
  @IBOutlet var placeholder: UIView!
  
  var cancellableCollector = [AnyCancellable]()
  var viewModel: CurrencyPairsViewModel! {
    didSet { bind() }
  }
  
  @IBAction func onAddPair(_ sender: AnyObject) {
    viewModel.addPairTriggered()
  }
  
  func bind() {
    bindToMain(viewModel.wasUpdated) { [weak self] (wasUpdated) in
      guard let self = self else { return }
      
      if wasUpdated && !self.tableView.isEditing {
        self.tableView.reloadData()
      }
    }
    
    bindToMain(viewModel.errorAlertText) { [weak self] (text) in
      guard let text = text else { return }
      self?.showAlert(title: "Error", message: text, buttonTitle: "Ok")
    }
  }
}

// MARK: - UITableViewDataSource
extension CurrencyPairsTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.pairsCount == 0 {
      tableView.backgroundView = placeholder
      return 0
    }
    tableView.backgroundView = nil
    return viewModel.pairsCount + 1
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      return tableView.dequeue(AddCurrencyPairCell.self, for: indexPath)
    }
    
    let cell = tableView.dequeue(CurrencyPairTableViewCell.self, for: indexPath)
    cell.setup(with: viewModel.currencyPair(at: indexPath.row - 1))
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      viewModel.deletePair(at: indexPath.row - 1)
      if viewModel.pairsCount > 0 {
        tableView.deleteRows(at: [indexPath], with: .fade)
      } else {
        tableView.reloadData()
      }
    }
  }
}

// MARK: - UITableViewDelegate
extension CurrencyPairsTableViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (indexPath.row == 0) {
      onAddPair(self)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 88
    }
    return 94
  }
}

// MARK: - Storyboarded
extension CurrencyPairsTableViewController: Storyboarded {}
// MARK: - AlertPresenter
extension CurrencyPairsTableViewController: AlertPresenter {}
