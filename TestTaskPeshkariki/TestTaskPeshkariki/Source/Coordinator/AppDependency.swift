//
//  AppDependency.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

protocol HasDependencies {
    var unsplashNetworkService: NetworkServiceProtocol { get }
    var persistentProvider: PersistentProviderProtocol { get }
}

class AppDependency {
    let networkService: NetworkService
    let persistent: PersistentProvider

    init(networkService: NetworkService,
         persistent: PersistentProvider) {
        self.networkService = networkService
        self.persistent = persistent
    }

    static func makeDefault() -> AppDependency {
        let networkService = NetworkService(customDecoder: JSONDecoderCustom())
        let persistent = PersistentProvider()
        return AppDependency(networkService: networkService, persistent: persistent)
    }
}

extension AppDependency: HasDependencies {
    var persistentProvider: PersistentProviderProtocol {
        return self.persistent
    }
    
    var unsplashNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
}
