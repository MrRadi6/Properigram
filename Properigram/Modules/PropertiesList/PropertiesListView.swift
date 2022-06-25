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
            VStack {
                // MARK: - Properties list view -
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
                // MARK: - Loading next page view -
                if viewModel.showPageLoader {
                    HStack {
                        Spacer()
                        ProgressView("properties_list_loading_more_properties".localized)
                        Spacer()
                    }
                }
            }
            .alert(viewModel.appError?.title ?? "",
                   isPresented: $viewModel.showError,
                   actions: {
                Button("global_ok_action".localized) {
                    viewModel.showError = false
                }
            },message: {
                Text(viewModel.appError?.message ?? "")
            })
            .navigationTitle("properties_list_View_properties_title".localized)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.reloadProperties()
            }
        }
    }
}
