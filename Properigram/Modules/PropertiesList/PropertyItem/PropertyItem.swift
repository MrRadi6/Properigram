//
//  PropertyItem.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import SwiftUI

struct PropertyItem: Identifiable {
    var id: UUID = UUID()
    var imageUrl: String?
    var address: String
}

extension PropertyItem {
    init(property: Property) {
        self.imageUrl = property.ImageUrl
        if property.address.isEmpty {
            self.address = "properties_list_empty_address".localized
        } else {
            self.address = property.address
        }
    }
}

extension PropertyItem: Equatable {}
