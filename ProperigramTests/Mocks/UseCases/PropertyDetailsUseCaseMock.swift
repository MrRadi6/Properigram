//
//  PropertyDetailsUseCaseMock.swift
//  ProperigramTests
//
//  Created by Samir on 6/25/22.
//

import Foundation
@testable import Properigram

class PropertyDetailsUseCaseMock: PropertyDetailsUseCaseProtocol {
    var propertyId: String?
    var property: PropertyDetails?
    var error: AppError?

    func getPropertyDetails(with id: String, completion: @escaping (Result<PropertyDetails, AppError>) -> Void) {
        self.propertyId = id
        if let property = property {
            completion(.success(property))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
