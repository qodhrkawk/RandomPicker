//
//  MainCustomTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import UIKit

class MainCustomTVC: UITableViewCell {
    static let identifier = "MainCustomTVC"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var myTitle: String?
    var candidates: [String]?
    var mainTableDelegate: MainTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)
        titleLabel.text = myTitle
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
        
        mainTableDelegate?.customTapped(title: myTitle ?? "질문하기",candidates: candidates ?? ["김댕댕"])
    }
}
