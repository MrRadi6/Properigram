//
//  BaseError.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

enum BaseError: Error {
    case systemError(message: String)
    case unknown

    var message: String {
        switch self {
        case .systemError(let message):
            return message
        case .unknown:
            return "global_unkown_network_error".localized
        }
    }
}
