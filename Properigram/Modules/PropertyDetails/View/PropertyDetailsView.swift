//
//  PropertyDetailsView.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct PropertyDetailsView: View {

    @StateObject var viewModel: PropertyDetailsViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let propertyDetails = viewModel.propertyDetails {
                PropertyImageView(imageURL: propertyDetails.imageURL)
                    .frame(height: 250)
                    .padding()
                PropertyDetailsItemView(title: "property_details_name_title".localized,
                                        description: propertyDetails.name)
                    .padding()
                PropertyDetailsItemView(title: "property_details_address_title".localized,
                                        description: propertyDetails.address)
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
        .navigationTitle("property_details_title".localized)
        .navigationBarTitleDisplayMode(.large)
    }
}


private struct PropertyImageView: View {
    var imageURL: String?

    var body: some View {
        PropertyImage(imageURL: imageURL)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 5)
    }
}

private struct PropertyDetailsItemView: View {
    let title: String
    let description: String

    var body: some View {
        HStack {
            Text(title)
                .frame(width: 80, alignment: .leading)
                .padding(.trailing, 10)
            Text(description)
            Spacer()
        }
    }
}
