//
//  CustomTableHeaderView.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit
import SnapKit
import Then

class CustomTableHeaderView: UIView {

    //MARK: - UI Component
    let sectionLabel = UILabel().then {
        $0.frame = CGRect(x: 0, y: 0, width: 81, height: 22)
        $0.textColor = .black
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!
        $0.sizeToFit()
    }
    
    var customLabel = UILabel().then {
        $0.text = "커스텀"
        $0.font = UIFont.systemFont(ofSize: 25)

    }
    
    var titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.systemFont(ofSize: 18)
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
        self.addSubview(customLabel)
        self.addSubview(titleLabel)
    }
    
    func setAutoLayout(){
        customLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(46)
            $0.leading.equalToSuperview().offset(23)
            
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(customLabel.snp.bottom).offset(51)
            $0.leading.equalToSuperview().offset(23)
        }
        
        
    }
    func setLabel(text: String){
        self.sectionLabel.text = text
    }
}
