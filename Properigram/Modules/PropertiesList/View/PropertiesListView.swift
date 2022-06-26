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
                PropertiesList(viewModel: viewModel)
                if viewModel.showPageLoader {
                    LoadMoreProperties()
                }
            }
            .alert(viewModel.appError?.title ?? "",
                   isPresented: $viewModel.showError,
                   actions: {
                Button("global_ok_action".localized, role: .cancel) {}
            },message: {
                Text(viewModel.appError?.message ?? "")
            })
            .navigationTitle("properties_list_View_properties_title".localized)
            .navigationBarTitleDisplayMode(.large)
            .overlay(content: {
                LoadingView(isLoading: $viewModel.isLoading)
            })
        }
    }
}

// MARK: - Properties List View
private struct PropertiesList: View {
    @ObservedObject var viewModel: PropertiesListViewModel

    var body: some View {
        List(viewModel.properties) { property in
            NavigationLink {
                PropertyDetailsNavigator.createModule(with: property.id)
            } label: {
                PropertyItemView(property: property)
            }
            .onAppear {
                viewModel.viewWillShow(item: property)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.reloadProperties()
        }
    }
}

// MARK: - Load more Properties View
private struct LoadMoreProperties: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView("properties_list_loading_more_properties".localized)
            Spacer()
        }
    }
}
