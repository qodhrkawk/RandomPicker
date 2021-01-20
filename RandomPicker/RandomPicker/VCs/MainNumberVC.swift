//
//  MainNumberVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit

class MainNumberVC: UIViewController {
    
    
    @IBOutlet weak var numberTV: UITableView!
    var numberArray: [NumberData] = []
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        updateArray()
        print(numberArray)
        print(numberArray.count)
        numberTV.dataSource = self
        numberTV.delegate = self
        numberTV.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateArray()
        numberTV.reloadData()
    }
    
    func updateArray(){
        if let numbers = defaults.value(forKey: "Number") as? Data{
            let originalArray = try? PropertyListDecoder().decode(Array<NumberData>.self, from: numbers)
            
            if originalArray != nil{
                numberArray = originalArray!
            }
            
        }
        
    }
    
    

   
}


extension MainNumberVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    
}

extension MainNumberVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainNumberTVC.identifier) as? MainNumberTVC
        else{return UITableViewCell()}
        
        cell.myTitle = numberArray[indexPath.row].title
        cell.startNum = numberArray[indexPath.row].firstRange
        cell.endNum = numberArray[indexPath.row].secondRange
        cell.mainTableDelegate = self
        cell.setLabel(input: numberArray[indexPath.row].title)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 150, 0, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DIdentity
            
        })
        
    }
    
}


extension MainNumberVC: MainTableDelegate {
    func  numberTapped(title: String, first: Int, second: Int) {
        guard let vcName = UIStoryboard(name: "Number", bundle: nil).instantiateViewController(identifier: "NumberResultVC") as? NumberResultVC else { return}
        
        vcName.myTitle = title
        vcName.firstRange = first
        vcName.secondRange = second
        
        self.navigationController?.pushViewController(vcName, animated: true)
    }
}
