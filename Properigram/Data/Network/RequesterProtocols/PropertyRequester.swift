//
//  PropertyRequester.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

protocol PropertyRequester {
    func getProperties(with page: Int,
                       propertiesPerPage: Int,
                       completion: @escaping (Result<PropertiesListDTO, BaseError>) -> Void)
    func getPropertyDetails(with id: String, completion: @escaping (Result<PropertyDetailsDTO, BaseError>) -> Void)
}
