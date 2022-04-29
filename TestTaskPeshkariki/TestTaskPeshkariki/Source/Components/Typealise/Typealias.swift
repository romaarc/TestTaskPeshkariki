//
//  Typealias.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation
//MARK: - For Dependencies
typealias ModuleDependencies = HasDependencies
//MARK: - For VIPER
typealias ViewInput = AnyObject & Errorable & Indicator
typealias InteractorInput = AnyObject & Reloadable
typealias InteractorOutput = AnyObject & Errorable
