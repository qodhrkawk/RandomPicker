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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeTV.delegate = self
        wholeTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setLabels(){
        wholeTV.reloadData()
        
    }
    
    
    
}


extension CustomResultVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let view = CustomResultHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90))
            view.setLabel(text: myTitle)
        
            return view
        default:
            let view = CustomCandidateTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

            return view


        }


    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 90
        default:

            return 50


        }


    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        switch indexPath.section{
        case 0:
            return 387
        default:

            return 67


        }

    }
}

extension CustomResultVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return candidates.count
            
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
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: CustomResultLIstTVC.identifier) as? CustomResultLIstTVC else {return UITableViewCell()}
            textCell.setPlaceHolder(text: "김윤재")
            textCell.setText(text: candidates[indexPath.row])
            textCell.customResultDelegate = self
            
            return textCell
        default:
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: CustomResultLIstTVC.identifier) as? CustomResultLIstTVC else {return UITableViewCell()}
            
            return textCell
        
        
        }
        
        
        
        
    }
    
    
    
    
}



extension CustomResultVC: CustomResultDelegate {
    func randomButtonAction() {
        
        
    }
    
    
}
