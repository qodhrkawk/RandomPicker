//
//  CustomResultHeader.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomResultHeader: UIView {

    var curIndex = 0

    
    var titleLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
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
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(23)
        }
        
        
    }
    func setLabel(text: String){
        self.titleLabel.text = text
    }
}
