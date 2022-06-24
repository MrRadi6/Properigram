//
//  APIResponse.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let data: T
}

struct APIResponseWithMeta<T: Decodable, M: Decodable>: Decodable {
    let data: T
    let meta: M
}
