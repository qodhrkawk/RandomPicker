//
//  CustomVCProtocol.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import Foundation

protocol CustomVCDelegate {
    func plusButtonAction()
    func textEndAction(text: String,idx: Int)
    func textBeginAction(idx: Int)
    
}


extension CustomVCDelegate {
    func plusButtonAction() { }
    func textEndAction(text: String,idx: Int) { }
    func textBeginAction(idx: Int) {}
}
