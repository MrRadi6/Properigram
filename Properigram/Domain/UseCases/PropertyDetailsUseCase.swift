//
//  PropertyDetailsUseCase.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import Foundation

protocol PropertyDetailsUseCaseProtocol {
    func getPropertyDetails(with id: String,
                            completion: @escaping (Result<PropertyDetails, AppError>) -> Void)
}

class PropertyDetailsUseCase: PropertyDetailsUseCaseProtocol {
    
    let repository: PropertyRepositoryProtocol

    init(repository: PropertyRepositoryProtocol) {
        self.repository = repository
    }

    func getPropertyDetails(with id: String,
                            completion: @escaping (Result<PropertyDetails, AppError>) -> Void) {
        repository.getPropertyDetails(with: id) { result in
            switch result {
            case .success(let propertyDetails):
                completion(.success(propertyDetails))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }
}

