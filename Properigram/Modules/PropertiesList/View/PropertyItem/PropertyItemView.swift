//
//  PropertyItemView.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct PropertyItemView: View {
    private let imageCornerRadius: CGFloat = 5
    let property: PropertyItem

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            PropertyImage(imageURL: property.imageUrl)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
                .padding(.trailing, 5)
            Text(property.address)
                .fontWeight(.regular)
                .lineLimit(1)
            Spacer()
        }
    }
}
