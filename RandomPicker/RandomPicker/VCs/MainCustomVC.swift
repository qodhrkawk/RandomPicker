//
//  MainCustomVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit

class MainCustomVC: UIViewController {

    var customArray: [CustomData] = []
    let defaults = UserDefaults.standard
    @IBOutlet weak var customTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        customTableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        customTableView.delegate = self
        customTableView.dataSource = self
        updateArray()
        print(customArray)
        
        // Do any additional setup after loading the view.
    }
    
    func updateArray(){
        if let numbers = defaults.value(forKey: "Custom") as? Data{
            let originalArray = try? PropertyListDecoder().decode(Array<CustomData>.self, from: numbers)
            
            if originalArray != nil{
                customArray = originalArray!
            }
            
        }
        
    }
    
    
    

}

extension MainCustomVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -150, 0, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DIdentity
            
        })
        
    }
    
}

extension MainCustomVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCustomTVC.identifier) as? MainCustomTVC
        else{return UITableViewCell()}
        
        cell.myTitle = customArray[indexPath.row].title
        cell.candidates = customArray[indexPath.row].candidates
       
        cell.mainTableDelegate = self
        cell.setLabel(input: customArray[indexPath.row].title)
        return cell
        
    }
    
    
    
}


extension MainCustomVC: MainTableDelegate {
    func customTapped(title: String,candidates: [String]) {
        
        
        guard let vcName = UIStoryboard(name: "Custom", bundle: nil).instantiateViewController(identifier: "CustomResultVC") as? CustomResultVC else { return}
        
        vcName.myTitle = title
        vcName.candidates = candidates
        
        self.navigationController?.pushViewController(vcName, animated: true)
        
    }
}
