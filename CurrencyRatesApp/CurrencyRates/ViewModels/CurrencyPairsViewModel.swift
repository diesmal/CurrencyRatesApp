//
//  CurrencyPairsViewModel.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 12.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import Combine

class CurrencyPairsViewModel {
  let currencyPairs: CurrencyPairsService
  let wasUpdated = PassthroughSubject<Bool, Never>()
  let errorText = CurrentValueSubject<String?, Never>(nil)
  var pairsCount: Int { currencyPairs.count }
  var updateTimer: Timer?
  weak var delegate: CurrencyChooserPresenter? = nil
  lazy var errorAlertText: AnyPublisher = {
    errorText.removeDuplicates().eraseToAnyPublisher()
  }()
  
  
  init(service: CurrencyPairsService) {
    currencyPairs = service
    updateRates()
  }
  
  func updateRates() {
    currencyPairs.updateRates { [weak self] (result) in
      guard let self = self else {
        return
      }
      switch result {
      case .success(let updated):
        self.wasUpdated.send(updated)
      case .failure(let error):
        self.errorText.value = error.localizedDescription
      }
      self.updateRates(in: 1)
    }
  }
  
  func updateRates(in seconds: TimeInterval) {
    DispatchQueue.main.async {
      self.updateTimer?.invalidate()
      self.updateTimer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false, block: { [weak self] (_) in
        self?.updateRates()
      })
    }
  }
  
  func currencyPair(at index: Int) -> CurrencyPair? {
    return currencyPairs[index]
  }
  
  func addPairTriggered() {
    guard !currencyPairs.isAddedAllPairs else {
      errorText.value = "All possible pairs was added"
      return
    }
    delegate?.showCurrencyChooser(viewModel: nil, completion: { [weak self] (firstCurrency, lastCurrency) in
      guard let first = firstCurrency,
      let last = lastCurrency else {
        return
      }
      let pair = CurrencyPair(first: first, last: last, rate: 0)
      self?.currencyPairs.add(pair)
      self?.updateTimer?.invalidate()
      self?.updateRates()
      self?.wasUpdated.send(true)
    })
  }
  
  func deletePair(at index: Int) {
    guard let pair = currencyPair(at: index) else {
      return
    }
    currencyPairs.remove(pair)
  }
}
