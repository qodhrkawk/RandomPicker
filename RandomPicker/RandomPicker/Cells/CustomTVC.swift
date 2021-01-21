//
//  CustomTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomTVC: UITableViewCell {
    
    static let identifier = "CustomTVC"
    
    var idx: Int?
    let border = CALayer()
    @IBOutlet weak var textField: UITextField!
    
    let triangle = UIImageView().then{
        $0.image = UIImage(named: "ic_textfield")
    }
    var customVCDelegate: CustomVCDelegate?
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
        textField.borderStyle = .none
        textField.layer.addSublayer(border)

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



extension CustomTVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.backgroundColor = UIColor.subpink2.cgColor
        triangle.alpha = 0
        customVCDelegate?.textEndAction(text: textField.text!,idx: idx ?? -1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        border.backgroundColor = UIColor.salmon.cgColor
        triangle.alpha = 1
       
        textField.borderStyle = .none
        textField.layer.addSublayer(border)
        customVCDelegate?.textBeginAction(idx: idx ?? -1)
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        customVCDelegate?.textEndAction(text: textField.text!,idx: idx ?? -1)
//        
//        return true
//    }
    
}


class TriangleView : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()

        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
        context.fillPath()
    }
}
