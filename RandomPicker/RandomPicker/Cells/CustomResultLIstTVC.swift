//
//  CustomResultLIstTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomResultLIstTVC: UITableViewCell {
    static let identifier = "CustomResultLIstTVC"
    
    @IBOutlet weak var textField: UITextField!
    var idx: Int?
    let border = CALayer()
    
    var customResultDelegate: CustomResultDelegate?
    let triangle = UIImageView().then{
        $0.image = UIImage(named: "ic_textfield")
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .subpink2
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextField()
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setTextField(){

        border.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: UIScreen.main.bounds.width-76, height: 3)
        border.backgroundColor = UIColor.subpink2.cgColor
        textField.addSubview(triangle)
        triangle.alpha =  0
        triangle.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(3)
            $0.width.height.equalTo(8)
            
        }
        textField.addSubview(lineView)
        textField.borderStyle = .none
        textField.layer.addSublayer(border)
        
        lineView.snp.makeConstraints{
            $0.height.equalTo(3)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(textField.snp.bottomMargin).offset(9)
        }

        textField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    }
    
    func setPlaceHolder(text: String) {
        textField.placeholder = text
        
    }
    
    func setText(text: String){
        textField.text = text
        
    }
    
    func firstResponder(){
        if textField.text == "" {
            print("called")
            UIView.animate(withDuration: 0.0, delay: 0.5, animations: {
                
                
            }, completion: {finished in
                UIView.animate(withDuration: 0.5,delay : 0, animations: {
                    self.textField.becomeFirstResponder()
                    
                })
            })
        }
    }
    @objc func textFieldDidChange(sender:UITextField) {
        
        if let text = sender.text {
            // 초과되는 텍스트 제거
            if text.count > 15 {
                let index = text.index(text.startIndex, offsetBy: 14)
                let newString = text[text.startIndex...index]
                sender.text = String(newString)
            }
            
        }
        
    }
  
}



extension CustomResultLIstTVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.backgroundColor = UIColor.subpink2.cgColor
        lineView.backgroundColor = .subpink2
        triangle.alpha = 0
        customResultDelegate?.textEndAction(text: textField.text!,idx: idx ?? -1)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        border.backgroundColor = UIColor.salmon.cgColor
        lineView.backgroundColor = .salmon
        triangle.alpha = 1

//        textField.borderStyle = .none
        textField.layer.addSublayer(border)
        customResultDelegate?.textBeginAction(idx: idx ?? -1)

    }
    
}
