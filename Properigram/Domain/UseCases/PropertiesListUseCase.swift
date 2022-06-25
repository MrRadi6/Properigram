//
//  PropertiesListUseCase.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import Foundation

protocol PropertiesListUseCaseProtocol {
    func getProperties(completion: @escaping (Result<[Property], AppError>) -> Void)
    func getMoreProperties(completion: @escaping (Result<[Property], AppError>) -> Void)
    func canGetMoreProperties() -> Bool
}

class PropertiesListUseCase: PropertiesListUseCaseProtocol {

    private let pageSize = 10
    private var page: PropertiesPage?

    let repository: PropertyRepositoryProtocol

    init(repository: PropertyRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProperties(completion: @escaping (Result<[Property], AppError>) -> Void) {
        repository.getProperties(with: 1, propertiesPerPage: pageSize) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properyPage):
                self.page = properyPage
                completion(.success(properyPage.properties))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }

    func getMoreProperties(completion: @escaping (Result<[Property], AppError>) -> Void) {
        guard let page = page else { return }
        guard page.currentPage < page.totalPages else { return }
        let nextPage = page.currentPage + 1
        
        repository.getProperties(with: nextPage, propertiesPerPage: pageSize) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properyPage):
                self.page = properyPage
                completion(.success(properyPage.properties))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }

    func canGetMoreProperties() -> Bool {
        guard let page = page else { return false }
        return page.currentPage < page.totalPages
    }
}
