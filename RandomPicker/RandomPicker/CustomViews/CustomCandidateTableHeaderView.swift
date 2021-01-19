//
//  CustomCandidateTableHeaderView.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomCandidateTableHeaderView: UIView {
    
    var curIndex = 0

    
    var titleLabel = UILabel().then {
        $0.text = "항목"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        $0.textColor = .salmon
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addView()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
      
        self.addSubview(titleLabel)
    }
    
    func setAutoLayout(){

        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(23)
        }
        
        
    }
    func setLabel(idx: Int){
        self.titleLabel.text = "항목🔖 (\(idx)/20)"
        let mainString = titleLabel.text
        
        let range = (mainString as! NSString).range(of: String("(\(idx)/20)"))
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString!)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.subpink1, range: range)
        
        titleLabel.attributedText = mutableAttributedString
    }
}
