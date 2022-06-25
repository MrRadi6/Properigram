//
//  PropertiesListView.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct PropertiesListView: View {
    @StateObject var viewModel: PropertiesListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.properties) { property in
                PropertyItemView(property: property)
                    .onAppear {
                        viewModel.viewWillShow(item: property)
                    }
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.reloadProperties()
            }
            .navigationTitle("properties_list_View_properties_title".localized)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.reloadProperties()
            }
        }
    }
}
