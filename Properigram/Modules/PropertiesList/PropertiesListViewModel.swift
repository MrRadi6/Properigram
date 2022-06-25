//
//  PropertiesListViewModel.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

protocol PropertiesListViewModelProtocol: ObservableObject {
    var properties: [PropertyItem] { get set }
    
    func reloadProperties()
    func viewWillShow(item: PropertyItem)
}

class PropertiesListViewModel {

    private let useCase: PropertiesListUseCaseProtocol

    @Published var properties: [PropertyItem] = []
    @Published var isLoading: Bool = false

    init(useCase:PropertiesListUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - Conforming to PropertiesListViewModelProtocol
extension PropertiesListViewModel: PropertiesListViewModelProtocol {
    func reloadProperties() {
        useCase.getProperties { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properties):
                self.properties = properties.map({ PropertyItem(property: $0)})
            case .failure(let error):
                dLog(error.message)
            }
        }
    }

    func viewWillShow(item: PropertyItem) {
        guard item == properties.last else { return }
        useCase.getMoreProperties { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let properties):
                let propertyItems = properties.map({ PropertyItem(property: $0)})
                self.properties.append(contentsOf: propertyItems)
            case .failure(let error):
                dLog(error.message)
            }
        }
    }
}
