//
//  PropertiesListNavigator.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct PropertiesListNavigator {

    static func createModule() -> PropertiesListView {
        let remoteAPI = PropertyAPI()
        let repository = PropertyRepository(remote: remoteAPI)
        let useCase = PropertiesListUseCase(repository: repository)
        let viewModel = PropertiesListViewModel(useCase: useCase)
        let view = PropertiesListView(viewModel: viewModel)
        return view
    }
}
