//
//  PropertiesDataMocks.swift
//  ProperigramTests
//
//  Created by Samir on 6/25/22.
//

import Foundation
@testable import Properigram

enum PropertiesDataMocks {
    static let propertyOne: Property = Property(id: "098-765-432",
                                                address: "0983 Area Street",
                                                imageUrl: "https://www.google.com/image1.jpg")
    
    static let propertyTwo: Property = Property(id: "123-456-789",
                                                address: "1234 Area Street",
                                                imageUrl: "https://www.google.com/image2.jpg")

    static let propertyPage: PropertiesPage = PropertiesPage(currentPage: 1,
                                                             totalPages: 10,
                                                             properties: [propertyOne, propertyTwo])

    static let propertySinglePage: PropertiesPage = PropertiesPage(currentPage: 1,
                                                                   totalPages: 1,
                                                                   properties: [propertyOne, propertyTwo])

    static let propertyDetails: PropertyDetails = PropertyDetails(name: "Property Name",
                                                                  address: "1234 Area Street",
                                                                  imageUrl: "https://www.google.com/image.jpg")
}
