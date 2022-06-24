//
//  PropertyPageDTO.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

struct PropertyPageDTO: Decodable {
    let currentPage: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPages = "last_page"
    }
}
