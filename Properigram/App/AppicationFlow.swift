//
//  AppicationFlow.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct AppicationFlow {

    func launchApp() -> some View {
        return PropertiesListNavigator.createModule()
    }
}
