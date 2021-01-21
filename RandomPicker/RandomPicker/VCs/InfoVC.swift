//
//  InfoVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/21.
//

import UIKit

class InfoVC: UIViewController {
    
    @IBOutlet weak var wholeScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeScrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func xButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}




extension InfoVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.y < 0 {

            let diffValue = abs(offset.y)
            var frame = scrollView.frame //현재 프레임 받음
            frame.size.height = max(0, 393 + diffValue)
            frame.origin.y = frame.minY - diffValue
            scrollView.frame = frame
            
        }
        
    }
    
    
}
