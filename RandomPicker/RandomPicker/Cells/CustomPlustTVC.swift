//
//  CustomPlustTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomPlustTVC: UITableViewCell {

    
    static let identifier = "CustomPlustTVC"
    @IBOutlet weak var plusButton: UIButton!
    
    var customVCDelegate: CustomVCDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func plusButtonAction(_ sender: Any) {
        print("aa")
        customVCDelegate?.plusButtonAction()
        
    }
    
    func removePlusButton(){
        plusButton.alpha = 0
    }
}
