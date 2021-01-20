//
//  CustomResultPlusTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit

class CustomResultPlusTVC: UITableViewCell {

    static let identifier = "CustomResultPlusTVC"
    @IBOutlet weak var plusButton: UIButton!
    
    var customResultDelegate: CustomResultDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func plusButtonAction(_ sender: Any) {

        customResultDelegate?.plusButtonAction()
        
    }
    
    func removePlusButton(){
        plusButton.alpha = 0
    }
}

