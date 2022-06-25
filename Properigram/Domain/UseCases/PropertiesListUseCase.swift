//
//  PropertiesListUseCase.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import Foundation

protocol PropertiesListUseCaseProtocol {
    func getProperties(completion: @escaping (Result<[Property], BaseError>) -> Void)
    func getMoreProperties(completion: @escaping (Result<[Property], BaseError>) -> Void)
}

class PropertiesListUseCase: PropertiesListUseCaseProtocol {

    private var page: PropertiesPage?
    let repository: PropertyRepositoryProtocol

    init(repository: PropertyRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProperties(completion: @escaping (Result<[Property], BaseError>) -> Void) {
        repository.getProperties(with: 1, propertiesPerPage: 10) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properyPage):
                self.page = properyPage
                completion(.success(properyPage.properties))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getMoreProperties(completion: @escaping (Result<[Property], BaseError>) -> Void) {
        guard let page = page else { return }
        let nextPage = page.currentPage + 1
        guard nextPage <= page.totalPages else { return }

        repository.getProperties(with: nextPage, propertiesPerPage: 10) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properyPage):
                self.page = properyPage
                completion(.success(properyPage.properties))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
