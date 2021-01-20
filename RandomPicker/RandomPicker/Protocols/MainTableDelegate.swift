//
//  MainTableDelegate.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import Foundation

protocol MainTableDelegate{
    
    func customTapped(title: String,candidates: [String])
    func numberTapped(title: String, first: Int, second: Int)
    
}

extension MainTableDelegate{
    func customTapped(title: String,candidates: [String]) {}
    func numberTapped(title: String, first: Int, second: Int) {}
    
    
}
