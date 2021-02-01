//
//  NumberResultVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit
import SAConfettiView
import GoogleMobileAds

class NumberResultVC: UIViewController {
    
    var myTitle: String?
    var firstRange = 0 {
        didSet{
            resulted = []
            print("called")
            let defaults = UserDefaults.standard
            if let numbers = defaults.value(forKey: "Number") as? Data{
                var originalArray = try? PropertyListDecoder().decode(Array<NumberData>.self, from: numbers)
                
                if originalArray != nil && originalArray!.count != 0{
                    for i in 0...originalArray!.count-1{
                        if originalArray![i].title == myTitle ?? "숫자 뽑기"{
                           var tmpData = NumberData(title: myTitle ?? "숫자 뽑기", firstRange: firstRange, secondRange: secondRange)
                            originalArray![i] = tmpData
                        }
                    }
                }
                
                defaults.set(try? PropertyListEncoder().encode(originalArray), forKey:"Number")
                
            }
            
        }
    }
    var secondRange = 99999{
        didSet{
            resulted = []
            print("called")
            let defaults = UserDefaults.standard
            if let numbers = defaults.value(forKey: "Number") as? Data{
                var originalArray = try? PropertyListDecoder().decode(Array<NumberData>.self, from: numbers)
                
                if originalArray != nil{
                    if originalArray!.count > 0 {
                        for i in 0...originalArray!.count-1{
                            if originalArray![i].title == myTitle ?? "숫자 뽑기"{
                               var tmpData = NumberData(title: myTitle ?? "숫자 뽑기", firstRange: firstRange, secondRange: secondRange)
                                originalArray![i] = tmpData
                            }
                        }
                    }
                  
                }
                
                defaults.set(try? PropertyListEncoder().encode(originalArray), forKey:"Number")
                
            }
        }
    }
    
    var resulted: [Int] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dupLabel: UILabel!
    @IBOutlet weak var dupSwitch: UISwitch!
    
    @IBOutlet weak var containView: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    var result = 0
    @IBOutlet var rangeTextFields: [UITextField]!
    
    @IBOutlet weak var wholeScrollView: UIScrollView!
    
    
    let borders: [CALayer] = [CALayer(),CALayer(),CALayer()]
    let triangle1 = UIImageView().then{
        $0.image = UIImage(named: "icTextfield")
    }
    let triangle2 = UIImageView().then{
        $0.image = UIImage(named: "icTextfield")
    }
    
    var mTimer : Timer?
    var confettiView: SAConfettiView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setItems(){
        setLabels()
        setImages()
        setTextFields()
        
        backgroundImageView.contentMode = .scaleToFill
        
        dupSwitch.onTintColor = .mango
        dupSwitch.transform = CGAffineTransform(scaleX: 36.0/49.0, y: 36.0/49.0)
        dupSwitch.decreaseThumb()
        containView.setBorder(borderColor: .subgrey, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 5)
        randomButton.backgroundColor = .mango
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.makeRounded(cornerRadius: 6)
        randomButton.setTitle("클릭해서 추첨하기", for: .normal)
        randomButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        wholeScrollView.delegate = self
    }
    
    func setLabels(){
        titleLabel.text = myTitle ?? "숫자 뽑기"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        titleLabel.textColor = .mango
        
        dupLabel.textColor = .brownGrey
        dupLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        
        infoLabel.text = "추첨 전인댕..."
        infoLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        infoLabel.textColor = .mango
        
        resultLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 42)
        resultLabel.alpha = 0
        
        rangeLabel.textColor = .mango
        rangeLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
    }
    
    func setImages(){
        
        dogImageView.image = UIImage(named: "imgDoggyDefalt")
        backgroundImageView.image = UIImage(named: "bgNumberpick")
        
        
    }
    
    func setTextFields(){
        for i in 0...1{
            borders[i].frame = CGRect(x: 0, y:  rangeTextFields[i].frame.size.height-1, width: 72, height: 3)
            borders[i].backgroundColor = UIColor.subyellow.cgColor
            rangeTextFields[i].font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
            rangeTextFields[i].borderStyle = .none
            rangeTextFields[i].layer.addSublayer(borders[i])
            
            rangeTextFields[i].delegate = self
        }
        
        rangeTextFields[0].addSubview(triangle1)
        triangle1.alpha =  0
        triangle1.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(1)
            $0.width.height.equalTo(8)
        }
        rangeTextFields[0].placeholder = "0"
        
        rangeTextFields[1].addSubview(triangle2)
        triangle2.alpha =  0
        triangle2.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(1)
            $0.width.height.equalTo(8)
        }
        rangeTextFields[1].placeholder = "99999"
        
       
        firstTextField.text = String(firstRange)
        secondTextField.text = String(secondRange)
        rangeTextFields[0].addTarget(self, action: #selector(firstDidChange(sender:)), for: .editingChanged)
        rangeTextFields[1].addTarget(self, action: #selector(secondDidChange(sender:)), for: .editingChanged)
        
    }
    
  
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func randomButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        self.wholeScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        dogImageView.image = UIImage(named: "imgDoggyThinking")
        randomButton.backgroundColor = .subgrey
        randomButton.setTitleColor(.veryLightPink, for: .normal)
        randomButton.setTitle("댕댕이가 추첨중...", for: .normal)
        randomButton.setBorder(borderColor: .white, borderWidth: 0.0)
        randomButton.isEnabled = false
        infoLabel.text = "내선택은..."
        resultLabel.alpha = 0
        
        if confettiView != nil {
            confettiView!.stopConfetti()
        }
        mTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: false)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        guard let vcName = UIStoryboard(name: "CustomAlert", bundle: nil).instantiateViewController(identifier: "CustomAlertVC") as? CustomAlertVC else {return}
        vcName.modalPresentationStyle = .overCurrentContext
        vcName.color = .mango
        vcName.customAlertDelegate = self
        self.present(vcName, animated: false, completion: nil)
    }
    
    @objc func firstDidChange(sender:UITextField) {
        
        if let text = sender.text {
            // 초과되는 텍스트 제거
            firstRange = Int(sender.text!)!
            if text.count > 5 {
                let index = text.index(text.startIndex, offsetBy: 4)
                let newString = text[text.startIndex...index]
                sender.text = String(newString)
                firstRange = Int(newString)!
            }
            
        }
        
    }
    
    @objc func secondDidChange(sender:UITextField) {
        
        if let text = sender.text {
            // 초과되는 텍스트 제거
            secondRange = Int(sender.text!)!
            if text.count > 5 {
                let index = text.index(text.startIndex, offsetBy: 4)
                let newString = text[text.startIndex...index]
                sender.text = String(newString)
                secondRange = Int(newString)!
            }
            
        }
        
    }
    @objc func timerCallback(){
        dogImageView.image = UIImage(named: "imgDoggyHappy")
        randomButton.backgroundColor = .white
        randomButton.setTitleColor(.mango, for: .normal)
        randomButton.setTitle("한번 더 추첨하기!", for: .normal)
        randomButton.setBorder(borderColor: .mango, borderWidth: 1.0)
        infoLabel.text = "정했다!"
        randomButton.isEnabled = true
        
        if dupSwitch.isOn {
            if firstRange <= secondRange{
                result = Int.random(in: firstRange...secondRange)
            }
            else{
                result = Int.random(in: secondRange...firstRange)
            }
            
            resultLabel.text = String(result)
        }
        else{
            
        

            while true{
                if firstRange <= secondRange{
                    result = Int.random(in: firstRange...secondRange)
                }
                else{
                    result = Int.random(in: secondRange...firstRange)
                }
                
                resultLabel.text = String(result)
                if !resulted.contains(result){
                    
                    break
                }
                
            }
            resulted.append(result)
            resultLabel.text = String(result)
            if abs(firstRange-secondRange) < resulted.count{
                randomButton.setTitle("다뽑앗댕", for: .normal)
                randomButton.isEnabled = false
            }
            
        }
        
        
        confettiView = SAConfettiView(frame: backgroundImageView.frame)
        backgroundImageView.addSubview(confettiView!)
        confettiView!.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        resultLabel.alpha = 1
        confettiView!.startConfetti()
       
        
       
        
        
    }
}


extension NumberResultVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case rangeTextFields[0]:
            borders[0].backgroundColor = UIColor.subyellow.cgColor
            triangle1.alpha = 0
            firstRange = Int(textField.text!) ?? 0
            if firstRange == 0{
                textField.text = "0"
            }
            
        default:
            borders[1].backgroundColor = UIColor.subyellow.cgColor
            triangle2.alpha = 0
            secondRange = Int(textField.text!) ?? 99999
            if secondRange == 99999{
                textField.text = "99999"
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        wholeScrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
        
        switch textField {
    
        case rangeTextFields[0]:
            borders[0].backgroundColor = UIColor.mango.cgColor
            triangle1.alpha = 1
            
        default:
            borders[1].backgroundColor = UIColor.mango.cgColor
            triangle2.alpha = 1
        }
        
        
    }
    

    
}

extension NumberResultVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        
    }
    
}

extension NumberResultVC: CustomAlertDelegate{
    
    func deleteTapped(){
        let defaults = UserDefaults.standard
        if let customs = defaults.value(forKey: "Number") as? Data{
            var originalArray = try? PropertyListDecoder().decode(Array<NumberData>.self, from: customs)
            var shouldDelete = -1
            
            if originalArray != nil{
                for i in 0...originalArray!.count-1{
                    if originalArray![i].title == myTitle {
                        shouldDelete = i
                    }
                }
            }
            if shouldDelete != -1{
                originalArray?.remove(at: shouldDelete)
            }
            
            
            defaults.set(try? PropertyListEncoder().encode(originalArray), forKey: "Number")
            
        }
            
        self.navigationController?.popViewController(animated: true)
    }
  
    
}

