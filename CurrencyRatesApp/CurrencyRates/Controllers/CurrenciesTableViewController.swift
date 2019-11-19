//
//  CurrenciesTableViewController.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 02.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UITableViewController {
  var viewModel: CurrenciesViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    isModalInPresentation = true
  }
}

// MARK: - UITableViewDataSource
extension CurrenciesTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.currenciesCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(CurrencyTableViewCell.self, for: indexPath)
    cell.setup(with: viewModel.currency(at: indexPath.row))
    cell.disable = !viewModel.isAvaliable(at: indexPath.row)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension CurrenciesTableViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelect(at: indexPath.row)
  }
}

// MARK: - Storyboarded
extension CurrenciesTableViewController: Storyboarded {}
// MARK: - AlertPresenter
extension CurrenciesTableViewController: AlertPresenter {}
