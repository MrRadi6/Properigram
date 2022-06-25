//
//  PropertiesListUseCaseMock.swift
//  ProperigramTests
//
//  Created by Samir on 6/25/22.
//

import Foundation
@testable import Properigram

class PropertiesListUseCaseMock: PropertiesListUseCaseProtocol {
    var properties: [Property]?
    var error: AppError?
    var isLastPage = false
    var isGetMoreCalled = false
    
    func getProperties(completion: @escaping (Result<[Property], AppError>) -> Void) {
        if let properties = properties {
            completion(.success(properties))
        } else if let error = error {
            completion(.failure(error))
        }
    }

    func getMoreProperties(completion: @escaping (Result<[Property], AppError>) -> Void) {
        isGetMoreCalled = true
        if let properties = properties {
            completion(.success(properties))
        } else if let error = error {
            completion(.failure(error))
        }
    }

    func canGetMoreProperties() -> Bool {
        return !isLastPage
    }
}
