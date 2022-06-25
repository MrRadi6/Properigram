//
//  PropertyRepositoryMock.swift
//  ProperigramTests
//
//  Created by Samir on 6/25/22.
//

import Foundation
@testable import Properigram

class PropertyRepositoryMock: PropertyRepositoryProtocol {
    var pageNumber: Int?
    var propertiesPerPage: Int?
    var propertyId: String?
    var propertiesPage: PropertiesPage?
    var propertyDetails: PropertyDetails?
    var error: BaseError?

    func getProperties(with page: Int,
                       propertiesPerPage: Int,
                       completion: @escaping (Result<PropertiesPage, BaseError>) -> Void) {
        self.pageNumber = page
        self.propertiesPerPage = propertiesPerPage
        if let propertiesPage = propertiesPage {
            completion(.success(propertiesPage))
        } else if let error = error {
            completion(.failure(error))
        }
    }

    func getPropertyDetails(with id: String,
                            completion: @escaping (Result<PropertyDetails, BaseError>) -> Void) {
        self.propertyId = id
        if let propertyDetails = propertyDetails {
            completion(.success(propertyDetails))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
