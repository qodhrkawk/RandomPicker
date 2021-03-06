//
//  MainVC.swift
//  RandomPicker
//
//  Created by Yunjae Kim on 2021/01/20.
//

import UIKit
import GoogleMobileAds

class MainVC: UIViewController {
    
    @IBOutlet weak var footButton: UIButton!

   
    @IBOutlet weak var customButton: UIButton!
    @IBOutlet weak var numberButton: UIButton!
    
    @IBOutlet weak var askButton: UIButton!
  
    var pageInstance : MainPVC?
    var nowIdx = 0
    var bannerView: GADBannerView!
    var isCustom = true
    
    let customImageView = UIImageView().then{
        $0.image = UIImage(named: "imgTitleCustom")
        $0.contentMode = .scaleAspectFit
    }
    let numberImageView = UIImageView().then{
        $0.image = UIImage(named: "imgTitleNumber")
        $0.contentMode = .scaleAspectFit
    }
    

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-7889100845612463/1211099576"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func setItems(){
      
        
        customButton.setTitle("커스텀🔖", for: .normal)
        customButton.setTitleColor(.salmon, for: .normal)
        customButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        
        numberButton.setTitle("숫자🔢", for: .normal)
        numberButton.setTitleColor(.subyellow, for: .normal)
        numberButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        
        askButton.backgroundColor = .salmon
        askButton.setTitleColor(.white, for: .normal)
        askButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        addCustomImageView()
        askButton.makeRounded(cornerRadius: 6)
        addBackgroundImageView()
        backgroundImageView.image = UIImage(named: "bgMainCustom")
        
        self.view.sendSubviewToBack(backgroundImageView)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainPVCSegue"{
            pageInstance = segue.destination as? MainPVC
            pageInstance?.mainPageDelegate = self

          
        }
        
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
//        bannerView.snp.makeConstraints{
//            $0.bottom.equalToSuperview().offset(140)
//            $0.centerX.equalToSuperview()
//
//
//        }
//
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .top,
                              relatedBy: .equal,
                              toItem: askButton,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 10),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    @IBAction func customButtonAction(_ sender: Any) {
        pageInstance?.setViewControllers([(pageInstance?.VCArray[0])!], direction: .reverse,
        animated: true, completion: nil)
        toCustom()
        isCustom = true
        
    }
    
    @IBAction func numberButtonAction(_ sender: Any) {
      
        pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .forward,
        animated: true, completion: nil)
        toNumber()
        isCustom = false
    }
    
    @IBAction func askButtonAction(_ sender: Any) {
        if isCustom{
            guard let vcName = UIStoryboard(name: "Custom", bundle: nil).instantiateViewController(identifier: "CustomVC") as? CustomVC else{return}
            
            self.navigationController?.pushViewController(vcName, animated: true)
        }
        else{
            guard let vcName = UIStoryboard(name: "Number", bundle: nil).instantiateViewController(identifier: "NumberVC") as? NumberVC else{return}
            
            self.navigationController?.pushViewController(vcName, animated: true)
            
        }
        
    }
    
    
    func addCustomImageView(){
        self.view.addSubview(customImageView)
        customImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(110)
            $0.width.equalTo(131)
            $0.height.equalTo(29)
        }
        
    }
    func addNumberImageView(){
        self.view.addSubview(numberImageView)
        numberImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(110)
            $0.width.equalTo(131)
            $0.height.equalTo(29)
        }
        
    }
    
    func addBackgroundImageView(){
        self.view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    
    func toNumber(){
        customButton.setTitleColor(.salmon20, for: .normal)
        numberButton.setTitleColor(.mango, for: .normal)
        askButton.setTitle("댕댕이에게 숫자 물어보기", for: .normal)
        askButton.backgroundColor = .mango

        
        UIView.transition(with: customImageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.customImageView.image = UIImage(named: "imgTitleNumber")
           
        }, completion: nil)

        UIView.transition(with: backgroundImageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.backgroundImageView.image = UIImage(named: "bgMainNumber")

           
        }, completion: nil)


        
    }
    
    func toCustom(){
        customButton.setTitleColor(.salmon, for: .normal)
        numberButton.setTitleColor(.mango20, for: .normal)
        askButton.setTitle("댕댕이에게 물어보기", for: .normal)
        askButton.backgroundColor = .salmon
        addCustomImageView()
        UIView.transition(with: customImageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.customImageView.image = UIImage(named: "imgTitleCustom")
            
        }, completion: nil)
        
        
        UIView.transition(with: backgroundImageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.backgroundImageView.image = UIImage(named: "bgMainCustom")
           
        }, completion: nil)
        

    }
    
    
    @IBAction func footButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(identifier: "InfoVC") as? InfoVC else{return}
        
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
    }
    
}


extension MainVC: MainPageDelegate{
    func moved(idx: Int) {
        if idx == 1{
           toNumber()
            isCustom = false
            
        }
        else{
            toCustom()
            isCustom = true
        }
        
        
    }
    
    
    
}


extension MainVC: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
    
}
