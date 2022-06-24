//
//  PropertyDTO.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

struct PropertyDTO: Decodable {
    let id: String
    let address: String
    let image: String?
}

// MARK: - Transfer to domain
extension PropertyDTO {
    func transferToProperty() -> Property {
        return Property(id: id,
                        address: address,
                        ImageUrl: image)
    }
}

