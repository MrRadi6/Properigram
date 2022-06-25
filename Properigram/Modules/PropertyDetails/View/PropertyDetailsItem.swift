//
//  PropertyDetailsItem.swift
//  Properigram
//
//  Created by Samir on 6/25/22.
//

import Foundation

struct PropertyDetailsItem {
    let name: String
    let address: String
    var imageURL: String?
}

extension PropertyDetailsItem {
    init(property: PropertyDetails) {
        self.name = property.name ?? "property_details_empty_name".localized
        if property.address.isEmpty {
            self.address = "property_details_empty_address".localized
        } else {
            self.address = property.address
        }
        self.imageURL = property.imageUrl
    }
}
