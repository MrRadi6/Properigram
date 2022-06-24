//
//  PropertyDetailsDTO.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

struct PropertyDetailsDTO: Decodable {
    let name: String?
    let address: String
    let image: String?
}

// MARK: - Transfer to domain
extension PropertyDetailsDTO {
    func transferToPropertyDetails() -> PropertyDetails {
        return PropertyDetails(name: name,
                               address: address,
                               imageUrl: image)
    }
}
