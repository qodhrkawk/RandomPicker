//
//  CustomData.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import Foundation

struct CustomData: Codable {
    var title: String
    var candidates: [String]
    
    init(title: String, candidates: [String]) {
        self.title = title
        self.candidates = candidates
    }
    
}
