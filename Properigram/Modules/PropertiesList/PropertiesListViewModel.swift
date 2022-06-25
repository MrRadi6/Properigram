//
//  PropertiesListViewModel.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

protocol PropertiesListViewModelProtocol: ObservableObject {
    func viewDidAppear()
    func reloadProperties()
    func viewWillShow(item: PropertyItem)
}

class PropertiesListViewModel {

    private let useCase: PropertiesListUseCaseProtocol

    @Published var properties: [PropertyItem] = []
    @Published var showPageLoader: Bool = false
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false

    var appError: AppError? {
        didSet {
            guard appError != nil else { return }
            showError = true
        }
    }
    
    init(useCase:PropertiesListUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - Conforming to PropertiesListViewModelProtocol
extension PropertiesListViewModel: PropertiesListViewModelProtocol {

    func viewDidAppear() {
        isLoading = true
        useCase.getProperties { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let properties):
                self.appError = nil
                self.properties = properties.map({ PropertyItem(property: $0)})
            case .failure(let error):
                self.appError = error
            }
        }
    }

    func reloadProperties() {
        useCase.getProperties { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properties):
                self.appError = nil
                self.properties = properties.map({ PropertyItem(property: $0)})
            case .failure(let error):
                self.appError = error
            }
        }
    }

    func viewWillShow(item: PropertyItem) {
        guard item == properties.last else { return }
        guard useCase.canGetMoreProperties() else { return }
        showPageLoader = true
        useCase.getMoreProperties { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properties):
                let propertyItems = properties.map({ PropertyItem(property: $0)})
                self.showPageLoader = false
                self.properties.append(contentsOf: propertyItems)
            case .failure(let error):
                self.appError = error
            }
        }
    }
}
