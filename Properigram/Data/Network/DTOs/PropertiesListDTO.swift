//
//  PropertiesListDTO.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

struct PropertiesListDTO {
    let properties: [PropertyDTO]
    let page: PropertyPageDTO
}

// MARK: - Transfer to domain
extension PropertiesListDTO {
    func transferToPropertiesPage() -> PropertiesPage {
        return PropertiesPage(currentPage: page.currentPage,
                              totalPages: page.totalPages,
                              properties: properties.map({ $0.transferToProperty() }))
    }
}
