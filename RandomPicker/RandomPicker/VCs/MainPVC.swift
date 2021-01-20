import UIKit

@objc class KVOObject : NSObject {
    @objc dynamic var curPresentViewIndex: Int = 0
    
}

class MainPVC: UIPageViewController {
    let identifiers = ["MainCustomVC","MainNumberVC"]
   
    var previousPage: UIViewController?
    var nextPage: UIViewController?
    var realNextPage: UIViewController?
    var mainPageDelegate: MainPageDelegate?
    
    var keyValue = KVOObject()
    
    lazy var VCArray : [UIViewController] = {
      
        
        return [self.VCInstane(storyboardName: "Main", vcName: "MainCustomVC"),
                self.VCInstane(storyboardName: "Main", vcName: "MainNumberVC")
        ]
        
    }()
    
    private func VCInstane(storyboardName : String, vcName : String) ->UIViewController{
        

        return UIStoryboard(name : storyboardName, bundle : nil).instantiateViewController(withIdentifier: vcName)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
}


extension MainPVC : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = VCArray.firstIndex(of: viewController) else {return nil}
        
        let prevIdx = vcIdx - 1
    
        
        if(prevIdx < 0){
            return nil
            
        }
        else{
          
            return VCArray[prevIdx]
        }
        
        
        
        
        
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = VCArray.firstIndex(of: viewController) else {return nil}
        
        let nextIdx = vcIdx + 1

        if(nextIdx >= VCArray.count){
            return nil
        }
        else{
           
            
            return VCArray[nextIdx]
        }
        
        
        
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if completed {
            previousPage = previousViewControllers[0]
            realNextPage = nextPage
            print(realNextPage)
            if realNextPage is RandomPicker.MainCustomVC {
                self.keyValue.curPresentViewIndex = 0
                mainPageDelegate?.moved(idx: 0)
            }
            else {
                self.keyValue.curPresentViewIndex = 1
                mainPageDelegate?.moved(idx: 1)
            }
          
        }

    }




    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        nextPage = pendingViewControllers[0]
    }


    
}


