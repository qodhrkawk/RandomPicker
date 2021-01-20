//
//  CustomResultVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/19.
//

import UIKit

class CustomResultVC: UIViewController {

    
    @IBOutlet weak var wholeTV: UITableView!
    
    var candidates: [String] = [""]
    var myTitle = ""
    var plusButton = false
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeTV.delegate = self
        wholeTV.dataSource = self
        wholeTV.contentInset.top = 0
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setLabels(){
        wholeTV.reloadData()
        
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
                self.bottomConstraint.constant = keyboardSize.height
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
                        self.bottomConstraint.constant = 0
                       })
        
        self.view.layoutIfNeeded()
    }
    
}


extension CustomResultVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let view = CustomResultHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90))
            view.setLabel(text: myTitle)
        
            return view
        case 1:
            let view = CustomCandidateTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            view.setLabel(idx: candidates.count)
            return view
        default:
            return nil

        }


    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 90
        case 1:
            return 50
        default:
            return 0


        }


    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        switch indexPath.section{
        case 0:
            return 387
        case 1:
            if indexPath.row >= candidates.count{
                return 300
            }
            return 67
        default:
            return 300

        }

    }
}

extension CustomResultVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return candidates.count + 1
        case 2:
            return 0
        default:
            return 0
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let resultCell = tableView.dequeueReusableCell(withIdentifier: CustomResultMainTVC.identifier) as? CustomResultMainTVC else {return UITableViewCell()}
            resultCell.candidates = candidates
            resultCell.customResultDelegate = self
            return resultCell
        case 1:
            if indexPath.row >= candidates.count{
                guard let plusCell = tableView.dequeueReusableCell(withIdentifier: CustomResultPlusTVC.identifier) as? CustomResultPlusTVC else {return UITableViewCell()}
                plusCell.customResultDelegate = self
                if candidates.count >= 20{
                    plusCell.removePlusButton()
                }
                return plusCell
            }
            
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: CustomResultLIstTVC.identifier) as? CustomResultLIstTVC else {return UITableViewCell()}
            textCell.setPlaceHolder(text: "김윤재")
            textCell.setText(text: candidates[indexPath.row])
            textCell.customResultDelegate = self
            textCell.idx = indexPath.row
            
            return textCell
        default:
            guard let plusCell = tableView.dequeueReusableCell(withIdentifier: CustomResultPlusTVC.identifier) as? CustomResultPlusTVC else {return UITableViewCell()}
            return plusCell
        
        
        }
        
        
        
        
    }
    
    
    
    
}



extension CustomResultVC: CustomResultDelegate {
    func randomButtonAction() {
        
        
    }
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
