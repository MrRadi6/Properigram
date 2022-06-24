//
//  MoviesRouter.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Alamofire

enum PropertiesRequest: BaseReqeust {
    case list(page: Int, propertiesPerPage: Int)
    case details(id: Int)

    var method: HTTPMethod {
        switch self {
        case .list, .details:
            return .get
        }
    }

    var path: String {
        switch self {
        case .list:
            return "\(Path.properties)"
        case .details(let id):
            return "\(Path.properties)/\(id)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .list(let page, let propertiesPerPage):
            return [Parameter.propertiesPerPage: propertiesPerPage,
                    Parameter.page: page]
        case .details:
            return nil
        }
    }
}

// MARK: - Constants
extension PropertiesRequest {
    enum Path {
        static let properties = "properties"
    }
    enum Parameter {
        static let page = "page"
        static let propertiesPerPage = "per_page"
    }
}
