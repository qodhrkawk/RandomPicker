//
//  CustomAlertVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import UIKit

class CustomAlertVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var color = UIColor.salmon
    var customAlertDelegate: CustomAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .systemBackground
        self.view.backgroundColor = .black60
        containerView.roundCorners(cornerRadius: 25.0, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        
        setLabels()
        setButtons()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.backgroundColor = .black60
//
//        }, completion: nil)
//
        
    }
    
    func setLabels(){
        titleLabel.textColor = .mainblack
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        subTitleLabel.textColor = .brownishGrey
        subTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        
    }
    
    func setButtons(){
        cancelButton.makeRounded(cornerRadius: 6)
        cancelButton.setTitleColor(color, for: .normal)
        cancelButton.setBorder(borderColor: color, borderWidth: 1.0)
        
        deleteButton.makeRounded(cornerRadius: 6)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = color
        
        
        
    }


    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func deleteButtonAction(_ sender: Any) {
       
        self.dismiss(animated: false, completion: {
            self.customAlertDelegate?.deleteTapped()
            
        })
        
        
    }
    

}
