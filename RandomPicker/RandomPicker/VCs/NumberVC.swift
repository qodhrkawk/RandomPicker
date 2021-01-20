//
//  NumberVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit

class NumberVC: UIViewController {
    
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet var rangeTextfields: [UITextField]!
    
    let borders: [CALayer] = [CALayer(),CALayer(),CALayer()]
    let triangle1 = UIImageView().then{
        $0.image = UIImage(named: "icTextfield")
    }
    let triangle2 = UIImageView().then{
        $0.image = UIImage(named: "icTextfield")
    }
    let triangle3 = UIImageView().then{
        $0.image = UIImage(named: "icTextfield")
    }
    
    var myTitle: String?
    var firstRange: Int?
    var secondRagne: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        setTextFields()
        // Do any additional setup after loading the view.
    }
    
    func setItems(){
        for label in labels{
            label.textColor = .mango
        }
        labels[0].font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        labels[1].font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        labels[2].font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        rangeLabel.font = UIFont(name: "AppleSDGothicNeo-ExtraBold", size: 20)
        rangeLabel.textColor = .mango
    }
    
    func setTextFields(){
        
        borders[0].frame = CGRect(x: 0, y: titleTextField.frame.size.height-1, width: UIScreen.main.bounds.width-76, height: 3)
        borders[0].backgroundColor = UIColor.subyellow.cgColor
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        titleTextField.borderStyle = .none
        titleTextField.layer.addSublayer(borders[0])
        titleTextField.addSubview(triangle1)
        titleTextField.delegate = self
        titleTextField.placeholder = "복권번호 뽑기"
        triangle1.alpha =  0
        triangle1.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(1)
            $0.width.height.equalTo(8)
        }
        for i in 0...1{
            borders[i+1].frame = CGRect(x: 0, y: titleTextField.frame.size.height-1, width: 72, height: 3)
            borders[i+1].backgroundColor = UIColor.subyellow.cgColor
            rangeTextfields[i].font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
            rangeTextfields[i].borderStyle = .none
            rangeTextfields[i].layer.addSublayer(borders[i+1])
            
            rangeTextfields[i].delegate = self
        }
        
        rangeTextfields[0].addSubview(triangle2)
        triangle2.alpha =  0
        triangle2.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(1)
            $0.width.height.equalTo(8)
        }
        rangeTextfields[0].placeholder = "0"
        
        rangeTextfields[1].addSubview(triangle3)
        triangle3.alpha =  0
        triangle3.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(1)
            $0.width.height.equalTo(8)
        }
        rangeTextfields[1].placeholder = "99999"
        
        rangeTextfields[0].addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        rangeTextfields[1].addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(sender:UITextField) {
        
        if let text = sender.text {
            // 초과되는 텍스트 제거
            if text.count > 5 {
                let index = text.index(text.startIndex, offsetBy: 4)
                let newString = text[text.startIndex...index]
                sender.text = String(newString)
            }
            
        }
        
    }
    
    
}


extension NumberVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case titleTextField:
            borders[0].backgroundColor = UIColor.subyellow.cgColor
            triangle1.alpha = 0
            myTitle = textField.text
        case rangeTextfields[0]:
            borders[1].backgroundColor = UIColor.subyellow.cgColor
            triangle2.alpha = 0
            firstRange = Int(textField.text!)
        default:
            borders[2].backgroundColor = UIColor.subyellow.cgColor
            triangle3.alpha = 0
            secondRagne = Int(textField.text!)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case titleTextField:
            borders[0].backgroundColor = UIColor.mango.cgColor
            triangle1.alpha = 1
        case rangeTextfields[0]:
            borders[1].backgroundColor = UIColor.mango.cgColor
            triangle2.alpha = 1
            
        default:
            borders[2].backgroundColor = UIColor.mango.cgColor
            triangle3.alpha = 1
        }
        
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        switch textField {
//        case titleTextField:
//            if textField.text!.count > 15{
//                return false
//            }
//        case rangeTextfields[0]:
//            if textField.text!.count > 5{
//                return false
//            }
//        default:
//            if textField.text!.count > 5{
//                return false
//            }
//        }
//
//        return true
//    }
    
}
