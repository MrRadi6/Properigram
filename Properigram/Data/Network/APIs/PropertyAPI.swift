//
//  PropertyAPI.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

struct PropertyAPI: BaseAPI, PropertyRequester {
    func getProperties(with page: Int, propertiesPerPage: Int, completion: @escaping (Result<PropertiesListDTO, BaseError>) -> Void) {
        makeMetaRequest(request: PropertiesRequest.list(page: page, propertiesPerPage: propertiesPerPage)) {
            (result: Result<([PropertyDTO], PropertyPageDTO), BaseError>) in
            switch result {
            case .success(let response):
                let properties = response.0
                let page = response.1
                let propertieListDTO = PropertiesListDTO(properties: properties,
                                                         page: page)
                completion(.success(propertieListDTO))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPropertyDetails(with id: String, completion: @escaping (Result<PropertyDetailsDTO, BaseError>) -> Void) {
        makeRequest(request: PropertiesRequest.details(id: id)) { (result: Result<PropertyDetailsDTO,BaseError>) in
            switch result {
            case .success(let propertyDetails):
                completion(.success(propertyDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
