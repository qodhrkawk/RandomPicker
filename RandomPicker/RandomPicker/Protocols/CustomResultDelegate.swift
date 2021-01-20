//
//  CustomResultDelegate.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import Foundation

protocol CustomResultDelegate{
    
    func randomButtonAction()
    func plusButtonAction()
    func textEndAction(text: String,idx: Int)
    func textBeginAction(idx: Int)
}

extension CustomResultDelegate{
    
    func randomButtonAction() {}
    func plusButtonAction() { }
    func textEndAction(text: String,idx: Int) { }
    func textBeginAction(idx: Int) {}
}
