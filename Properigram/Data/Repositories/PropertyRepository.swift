//
//  PropertyRepository.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

protocol PropertyRepositoryProtocol {
    func getProperties(with page: Int,
                       propertiesPerPage: Int,
                       completion: @escaping (Result<PropertiesPage, BaseError>) -> Void)
    func getPropertyDetails(with id: String, completion: @escaping (Result<PropertyDetails, BaseError>) -> Void)
}

struct PropertyRepository: PropertyRepositoryProtocol {
    let remote: PropertyRequester
    
    func getProperties(with page: Int, propertiesPerPage: Int, completion: @escaping (Result<PropertiesPage, BaseError>) -> Void) {
        remote.getProperties(with: page,
                             propertiesPerPage: propertiesPerPage) { result in
            switch result {
            case .success(let propertiesListDTO):
                let propertyPage = propertiesListDTO.transferToPropertiesPage()
                completion(.success(propertyPage))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPropertyDetails(with id: String, completion: @escaping (Result<PropertyDetails, BaseError>) -> Void) {
        remote.getPropertyDetails(with: id) { result in
            switch result {
            case .success(let propertyDetailsDTO):
                let propertyDetails = propertyDetailsDTO.transferToPropertyDetails()
                completion(.success(propertyDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
