//
//  UISwitch+Extensions.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit

extension UISwitch {

func decreaseThumb(){
    if let thumb = self.subviews[0].subviews[1].subviews[2] as? UIImageView {
        thumb.transform = CGAffineTransform(scaleX:0.85, y: 0.85)
    }
  }
}
