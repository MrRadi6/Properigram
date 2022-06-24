//
//  String+Localizable.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
