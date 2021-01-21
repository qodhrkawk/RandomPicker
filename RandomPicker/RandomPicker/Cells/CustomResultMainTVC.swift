//
//  CustomResultMainTVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit
import SAConfettiView



class CustomResultMainTVC: UITableViewCell {

    static let identifier = "CustomResultMainTVC"
    
    @IBOutlet weak var dupLabel: UILabel!
    @IBOutlet weak var dupSwitch: UISwitch!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var innerImageView: UIImageView!
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    var mTimer : Timer?
    var customResultDelegate: CustomResultDelegate?
    var confettiView: SAConfettiView?
    
    var resulted: [Int] = []
    
    var candidates: [String] = [] {
        didSet {
            resulted = []
        }
    }
    var result: Int = 0
    
    let resultLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        $0.textColor = .mainblack
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setItems()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItems(){

        dupLabel.text = "중복추첨"
        dupLabel.textColor = .veryLightPink
        
        dupSwitch.onTintColor = .salmon
        dupSwitch.transform = CGAffineTransform(scaleX: 36.0/49.0, y: 36.0/49.0)
        dupSwitch.decreaseThumb()
        containerView.setBorder(borderColor: .subgrey, borderWidth: 1.0)
        
        innerImageView.image = UIImage(named: "bgCustompick")
        innerImageView.contentMode = .scaleToFill
        
        randomButton.makeRounded(cornerRadius: 6)
        randomButton.backgroundColor = .salmon
        randomButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        dogImage.image = UIImage(named: "imgDoggyDefalt")
        
        infoLabel.textColor = .salmon
        infoLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)
        
    }
    
    @objc func timerCallback(){
        dogImage.image = UIImage(named: "imgDoggyHappy")
        randomButton.backgroundColor = .white
        randomButton.setTitleColor(.salmon, for: .normal)
        randomButton.setTitle("한번 더 추첨하기!", for: .normal)
        randomButton.setBorder(borderColor: .salmon, borderWidth: 1.0)
        infoLabel.text = "정했다!"
        randomButton.isEnabled = true
        
        confettiView = SAConfettiView(frame: innerImageView.frame)
        innerImageView.addSubview(confettiView!)
        confettiView!.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        confettiView!.startConfetti()
        if candidates.count > 0{
            if dupSwitch.isOn {

                result = Int.random(in: 0...candidates.count-1)
                resultLabel.text = candidates[result]
            }
            else{
                
            

                while true{
                    result = Int.random(in: 0...candidates.count-1)
                    if !resulted.contains(result){
                        
                        break
                    }
                    
                }
                resulted.append(result)
                resultLabel.text = candidates[result]
                
                if candidates.count <= resulted.count{
                    randomButton.setTitle("다뽑앗댕", for: .normal)
                    randomButton.isEnabled = false
                }
                
            }

        }
        
        self.addSubview(resultLabel)
       
        resultLabel.snp.makeConstraints{
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        
        
    }
    
    @IBAction func randomButtonAction(_ sender: Any) {
        customResultDelegate?.randomButtonAction()
        dogImage.image = UIImage(named: "imgDoggyThinking")
        randomButton.backgroundColor = .subgrey
        randomButton.setTitleColor(.veryLightPink, for: .normal)
        randomButton.setTitle("댕댕이가 추첨중...", for: .normal)
        randomButton.setBorder(borderColor: .white, borderWidth: 0.0)
        randomButton.isEnabled = false
        infoLabel.text = "내선택은..."
        
        if confettiView != nil {
            confettiView!.stopConfetti()
        }
        
        mTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: false)
        
        
    }
    

}

