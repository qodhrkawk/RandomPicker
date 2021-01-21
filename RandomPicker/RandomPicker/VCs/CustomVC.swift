//
//  CustomVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomVC: UIViewController {
    
    @IBOutlet weak var wholeTV: UITableView!
    var curNum = 0
    
    var candidates: [String] = [""]
    var myTitle: String?
    var plusButton = false
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableViewButtomConstraint: NSLayoutConstraint!
    let deviceBound = UIScreen.main.bounds.height/667.0
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeTV.delegate = self
        wholeTV.dataSource = self
        print(deviceBound)
        backgroundImage.image = UIImage(named: "bgCustom")
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        wholeTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.view.endEditing(true)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
                                                UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
                                                UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
//                self.wholeTV.transform =
//                    CGAffineTransform(translationX: 0, y: -(keyboardSize.height-150))
                self.tableViewButtomConstraint.constant = keyboardSize.height
            })
            self.view.layoutIfNeeded()
            
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
                as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                       animations: {
//                        self.wholeTV.transform = .identity
                        self.tableViewButtomConstraint.constant = 0
                       })
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        guard let vcName = UIStoryboard(name: "Custom", bundle: nil).instantiateViewController(identifier: "CustomResultVC") as? CustomResultVC else { return}
        
        var inputCandidate = candidates
        for i in 0...inputCandidate.count-1{
            if inputCandidate[i] == ""{
                inputCandidate[i] = "김댕댕"
            }
        }
        
        vcName.candidates = inputCandidate
     
        vcName.myTitle = myTitle ?? "질문하기"
//        vcName.setLabels()
        
        var newArray: [CustomData] = []
        let newData = CustomData(title: myTitle ?? "질문하기", candidates: inputCandidate)
        let defaults = UserDefaults.standard
        newArray.append(newData)
     
        if let customs = defaults.value(forKey: "Custom") as? Data{
            var originalArray = try? PropertyListDecoder().decode(Array<CustomData>.self, from: customs)
            if originalArray != nil  {
                var flag = true
                if originalArray!.count != 0{
                    for i in 0...originalArray!.count-1{
                        if originalArray![i].title == newData.title {
                            originalArray![i] = newData
                            flag = false
                        }
                    }
                    
                }
               
                if flag{
                    originalArray?.append(newData)
                }
            }
            
          
            defaults.set(try? PropertyListEncoder().encode(originalArray), forKey:"Custom")
        }
        else{
            defaults.set(try? PropertyListEncoder().encode(newArray), forKey:"Custom")
        }
        
        guard let navi = self.navigationController else {return}
        
        self.navigationController?.popViewController(animated: false)
        navi.pushViewController(vcName, animated: true)
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension CustomVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let view = CustomTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 179))
            return view
        default:
            let view = CustomCandidateTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            view.setLabel(idx: candidates.count)
            return view
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 139
        default:
            
            return 50
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row >= candidates.count{
            return 300*deviceBound
        }
        
        
        return 67
    }
    
    
}

extension CustomVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return candidates.count+1
         
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVC.identifier) as? CustomTVC else {return UITableViewCell()}
        switch indexPath.section{
        case 0:
//            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: CustomTitleTVC.identifier) as? CustomTitleTVC else {return UITableViewCell()}
//            titleCell.setPlaceHolder(text: "설거지 당번 정하기")
//            titleCell.setText(text: "")
//            titleCell.customVCDelegate = self
//            return titleCell
            
            cell.setPlaceHolder(text: "설거지 당번 정하기")
            cell.idx = -1
            if myTitle != nil {
                cell.setText(text: myTitle!)
            }
            
        default:
            
            
            if indexPath.row >= candidates.count {
                guard let plusCell = tableView.dequeueReusableCell(withIdentifier: CustomPlustTVC.identifier) as? CustomPlustTVC else {return UITableViewCell()}
                plusCell.customVCDelegate = self
                if candidates.count >= 20{
                    plusCell.removePlusButton()
                }
                
                return plusCell
            }
            
            cell.setPlaceHolder(text: "김댕댕")
            if indexPath.row < candidates.count && indexPath.section > 0 {
                cell.setText(text: candidates[indexPath.row])
            }
            
            if plusButton && indexPath.row == candidates.count-1 {
                cell.firstResponder()
                UIView.animate(withDuration: 0.5, animations: {
                    self.wholeTV.scrollToRow(at: IndexPath(row: indexPath.row, section: 1), at: .top, animated: false)
                })
                plusButton = false
            }
            
            cell.idx = indexPath.row
            
            
        }
        cell.customVCDelegate = self
       
        
       
        
        
        return cell
    }
    
    
    
    
}

extension CustomVC: CustomVCDelegate {
    func plusButtonAction() {
        
        
        candidates.append("")
        plusButton = true
        wholeTV.reloadData()
     
        
        
    }
    
    func textEndAction(text: String,idx: Int) {
        if idx != -1{
            candidates[idx] = text
            wholeTV.reloadData()
        }
        else{
            myTitle = text
        }
       
        
    }
    func textBeginAction(idx: Int) {
        print("why")
        
        if idx == -1{
            wholeTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                self.wholeTV.scrollToRow(at: IndexPath(row: idx, section: 1), at: .top, animated: false)
            })
            
        }
       
        
    }
}
