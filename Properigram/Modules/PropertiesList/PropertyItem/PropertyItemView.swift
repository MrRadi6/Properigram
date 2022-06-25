//
//  PropertyItemView.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI
import Kingfisher

struct PropertyItemView: View {
    let property: PropertyItem

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            PropertyImageView(imageURL: property.imageUrl)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.trailing, 5)
            Text(property.address)
                .fontWeight(.regular)
                .lineLimit(1)
            Spacer()
        }
    }
}

private struct PropertyImageView: View {
    var imageURL: String?

    var body: some View {
        if let imageURL = imageURL {
            KFImage.url(URL(string: imageURL))
                .onFailureImage(.propertyPlaceholder)
                .processingQueue(.dispatch(.global()))
                .cacheMemoryOnly()
                .cancelOnDisappear(true)
                .fade(duration: 0.3)
                .cacheMemoryOnly()
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image.propertyPlaceholder
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}
