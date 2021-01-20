//
//  NumberResultVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit

class NumberResultVC: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dupLabel: UILabel!
    @IBOutlet weak var dupSwitch: UISwitch!
    
    @IBOutlet weak var containView: UIView!
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    
    @IBOutlet var rangeTextFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    
}
