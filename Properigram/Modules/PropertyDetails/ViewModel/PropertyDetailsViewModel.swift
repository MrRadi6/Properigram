//
//  PropertyDetailsViewModel.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

protocol PropertyDetailsViewModelProtocol {
    func viewDidAppear()
}

class PropertyDetailsViewModel: BaseViewModel {

    private let useCase: PropertyDetailsUseCaseProtocol

    @Published var propertyDetails: PropertyDetailsItem? = nil
    var propertyId: String?

    init(useCase: PropertyDetailsUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - Conforming to PropertyDetailsViewModelProtocol
extension PropertyDetailsViewModel: PropertyDetailsViewModelProtocol {
    func viewDidAppear() {
        guard let propertyId = propertyId else { return }
        isLoading = true
        useCase.getPropertyDetails(with: propertyId) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let propertyDetails):
                self.propertyDetails = PropertyDetailsItem(property: propertyDetails)
            case .failure(let error):
                self.appError = error
            }
        }
    }
}
