//
//  MainNumberTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import UIKit

class MainNumberTVC: UITableViewCell {
    static let identifier = "MainNumberTVC"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var myTitle: String?
    var startNum: Int?
    var endNum: Int?
    
    var mainTableDelegate: MainTableDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = myTitle
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)
        setItems()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setItems(){
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        containerView.backgroundColor = .white80
        containerView.setBorder(borderColor: .subgrey, borderWidth: 1.0)
        containerView.makeRounded(cornerRadius: 5)
        
        containerView.isUserInteractionEnabled = true
        let containTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpContainView))
        containerView.addGestureRecognizer(containTabGesture)
        
    }
    
    func setLabel(input: String){
        titleLabel.text = input
    }
    

    @objc func touchUpContainView(){
        
        mainTableDelegate?.numberTapped(title: myTitle ?? "숫자 뽑기", first: startNum ?? 0, second: endNum ?? 99999)
    }
}
