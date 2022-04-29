//
//  Errorable.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

protocol Errorable {
    func didError()
    func didError(with error: Error)
}

extension Errorable {
    func didError(with error: Error) {}
    func didError() {}
}
