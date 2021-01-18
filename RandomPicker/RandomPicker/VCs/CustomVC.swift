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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeTV.delegate = self
        wholeTV.dataSource = self
        
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
            return view

        
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 179
        default:

            return 50

        
        }
        
        
    }
    
    
}

extension CustomVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVC.identifier) as? CustomTVC else {return UITableViewCell()}
        
        return cell
    }
    
    
}
