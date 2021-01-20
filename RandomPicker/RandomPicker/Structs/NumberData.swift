//
//  NumberData.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import Foundation
struct NumberData: Codable {
    var title: String
    var firstRange: Int
    var secondRange: Int
    
    init(title: String, firstRange: Int,secondRange: Int) {
        self.title = title
        self.firstRange = firstRange
        self.secondRange = secondRange
    }
    
}
