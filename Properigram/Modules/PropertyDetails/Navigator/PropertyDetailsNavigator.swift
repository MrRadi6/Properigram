//
//  PropertyDetailsNavigator.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct PropertyDetailsNavigator {
    static func createModule(with id: String) -> PropertyDetailsView {
        let propertyAPI = PropertyAPI()
        let repository = PropertyRepository(remote: propertyAPI)
        let useCase = PropertyDetailsUseCase(repository: repository)
        let viewModel = PropertyDetailsViewModel(useCase: useCase)
        let view = PropertyDetailsView(viewModel: viewModel)
        viewModel.propertyId = id
        return view
    }
}
