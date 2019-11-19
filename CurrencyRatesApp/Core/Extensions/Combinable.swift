//
//  Combinable.swift
//  ThisOrThat
//
//  Created by Ilia Nikolaenko on 08.09.19.
//  Copyright © 2019 Ilya Nikolaenko. All rights reserved.
//

import Foundation
import Combine

protocol Combinable: class {
    var cancellableCollector: [AnyCancellable] { get set }
}

extension Combinable {
    func bindToMain<S: Publisher>(_ subject: S, receiveValue: @escaping ((S.Output) -> Void)) where S.Failure == Never {
      let cancellable = subject.receive(on: RunLoop.main).sink(receiveValue: receiveValue)
           cancellableCollector.append(cancellable)
    }
    
    func bind<S: Publisher>(_ subject: S, receiveValue: @escaping ((S.Output) -> Void)) where S.Failure == Never {
           let cancellable = subject.sink(receiveValue: receiveValue)
           cancellableCollector.append(cancellable)
    }
}
