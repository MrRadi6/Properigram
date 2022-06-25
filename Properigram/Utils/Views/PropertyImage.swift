//
//  PropertyImage.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI
import Kingfisher

struct PropertyImage: View {
    var imageURL: String?
    
    var body: some View {
        if let imageURL = imageURL {
            KFImage.url(URL(string: imageURL))
                .onFailureImage(.propertyPlaceholder)
                .processingQueue(.dispatch(.global()))
                .cacheMemoryOnly()
                .fade(duration: 0.3)
                .cacheMemoryOnly()
                .resizable()
        } else {
            Image.propertyPlaceholder
                .resizable()
        }
    }
}
