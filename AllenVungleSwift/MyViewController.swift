//
//  ViewController.swift
//  AllenVungleSwift
//
//  Created by allen.liu on 2021/11/9.
//

import UIKit
import AppTrackingTransparency

class MyViewController: UIViewController,VungleSDKDelegate {
 
    
    @IBOutlet weak var MyStackView: UIStackView!
    @IBOutlet weak var MyInitButton: UIButton!
    @IBOutlet weak var MyInsPlacementID: UILabel!
    @IBOutlet weak var MyIntLoadBtn: UIButton!
    @IBOutlet weak var MyIntPlayBtn: UIButton!
    @IBOutlet weak var MyRewardPlacementID: UILabel!
    @IBOutlet weak var MyRewardLoadBtn: UIButton!
    @IBOutlet weak var MyRewardPlayBtn: UIButton!
    @IBOutlet weak var MyMrecPlacementID: UILabel!
    @IBOutlet weak var MyMrecLoadBtn: UIButton!
    @IBOutlet weak var MyMrecPlayBtn: UIButton!
    @IBOutlet weak var MyMrecCloseBtn: UIButton!
    @IBOutlet weak var MyBannerPlacementID: UILabel!
    @IBOutlet weak var MyBannerLoadBtn: UIButton!
    @IBOutlet weak var MyBannerPlayBtn: UIButton!
    @IBOutlet weak var MyBannerCloseBtn: UIButton!
    var adview: UIView!
    var sdk:VungleSDK=VungleSDK.shared()
    var screenHeight:CGFloat?
    var screenWidth:CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14, *){
            ATTrackingManager.requestTrackingAuthorization {status in
                print("status %@", status)
            }
        }
        self.setViewDefalut()
        // Do any additional setup after loading the view.
    }

    
    
    func setViewDefalut(){
        self.MyInsPlacementID.text = MyConstant.interstitialPlacement
        self.MyRewardPlacementID.text = MyConstant.rewardPlacement
        self.MyMrecPlacementID.text = MyConstant.mrecPlacement
        self.MyBannerPlacementID.text = MyConstant.bannerPlacement
        disablePlayLoadButtonsWithoutInitBtn()
    }
    
    func startVungle(){
        updateButtonState(button: MyInitButton, enabled: false)
        
        sdk.update(VungleConsentStatus.accepted, consentMessageVersion: "accept")
        sdk.update(VungleCCPAStatus.accepted)
        sdk.delegate=self
        do {
            try sdk.start(withAppId: MyConstant.appId)
            updateButtonState(button: MyInitButton, enabled: false)
        } catch {
           print(error)
            print("Unable to load placement with reference ID %@:, Error %@", MyConstant.interstitialPlacement, error)
            updateButtonState(button: MyInitButton, enabled: true)
           // or display a dialog
        }
    }

  

    func updateButtons(){
//        updateButtonState(button: MyInitButton, enabled: sdk.isAdCached(forPlacementID: MyInsPlacementID))
        updateButtonState(button: MyIntLoadBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.interstitialPlacement) ? false : true)
        updateButtonState(button: MyIntPlayBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.interstitialPlacement) ? true : false)
        updateButtonState(button: MyRewardLoadBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.rewardPlacement) ? false : true)
        updateButtonState(button: MyRewardPlayBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.rewardPlacement) ? true : false)
        updateButtonState(button: MyMrecLoadBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.mrecPlacement) ? false : true)
        updateButtonState(button: MyMrecPlayBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.mrecPlacement) ? true : false)
        updateButtonState(button: MyBannerLoadBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.bannerPlacement) ? false : true)
        updateButtonState(button: MyBannerPlayBtn, enabled: sdk.isAdCached(forPlacementID: MyConstant.bannerPlacement) ? true : false)

    }
    
    
    func disablePlayLoadButtonsWithoutInitBtn(){
        updateButtonState(button: MyInitButton, enabled: true)
        updateButtonState(button: MyIntLoadBtn, enabled: false)
        updateButtonState(button: MyIntPlayBtn, enabled: false)
        updateButtonState(button: MyRewardLoadBtn, enabled: false)
        updateButtonState(button: MyRewardPlayBtn, enabled: false)
        updateButtonState(button: MyMrecPlayBtn, enabled: false)
        updateButtonState(button: MyMrecLoadBtn, enabled: false)
        updateButtonState(button: MyMrecCloseBtn, enabled: false)
        updateButtonState(button: MyBannerPlayBtn, enabled: false)
        updateButtonState(button: MyBannerLoadBtn, enabled: false)
        updateButtonState(button: MyBannerCloseBtn, enabled: false)
        
    }
    
    
    func updateButtonState(button: UIButton,enabled: Bool){
        button.isEnabled = enabled
        button.alpha = enabled ? 1.0 : 0.5
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func OnClickInitButton(_ sender: Any) {
       startVungle()
    }
    
    @IBAction func OnClickInsLoadButton(_ sender: Any) {
        do {
            try  sdk.loadPlacement(withID: MyConstant.interstitialPlacement)
            updateButtonState(button: MyIntLoadBtn, enabled: false)
        } catch {
           print("Unable to load placement with reference ID %@:, Error %@", MyConstant.interstitialPlacement, error)
            updateButtonState(button: MyIntLoadBtn, enabled: true)
           // or display a dialog
        }
    }
    
    
    @IBAction func OnClickInsPlayButton(_ sender: Any) {
        do {
            try     sdk.playAd(self, options: nil, placementID: MyConstant.interstitialPlacement)
            updateButtonState(button: MyIntPlayBtn, enabled: false)
        } catch {
            updateButtonState(button: MyIntPlayBtn, enabled: true)
           print("Unable to play placement with reference ID %@:, Error %@", MyConstant.interstitialPlacement, error)
           // or display a dialog
        }
        disablePlayLoadButtonsWithoutInitBtn()
    }
    
    @IBAction func OnClickRewardLoadButton(_ sender: Any) {
        do {
            try  sdk.loadPlacement(withID: MyConstant.rewardPlacement)
            updateButtonState(button: MyRewardLoadBtn, enabled: false)
        } catch {
            updateButtonState(button: MyRewardLoadBtn, enabled: true)
           print("Unable to load placement with reference ID %@:, Error %@", MyConstant.rewardPlacement, error)
            
           // or display a dialog
        }
    }
    @IBAction func OnClickRewardPlayButton(_ sender: Any) {
        do {
            try     sdk.playAd(self, options: nil, placementID: MyConstant.rewardPlacement)
            updateButtonState(button: MyRewardPlayBtn, enabled: false)
        } catch {
            updateButtonState(button: MyRewardPlayBtn, enabled: true)
           print("Unable to play placement with reference ID %@:, Error %@", MyConstant.rewardPlacement, error)
           // or display a dialog
        }
        disablePlayLoadButtonsWithoutInitBtn()
    }
    @IBAction func OnClickMrecLoadButton(_ sender: Any) {
        do {
            try  sdk.loadPlacement(withID: MyConstant.mrecPlacement)
            updateButtonState(button: MyMrecLoadBtn, enabled: false)
        } catch {
            updateButtonState(button: MyMrecLoadBtn, enabled: true)
           print("Unable to load placement with reference ID %@:, Error %@", MyConstant.mrecPlacement, error)
            
           // or display a dialog
        }
    }
    @IBAction func OnClickMrecPlayButton(_ sender: Any) {
     
        getScreenDimension()
        adview = UIView.init(frame: CGRect(x: (screenWidth! / 2) - (MyConstant.MREC_AD_WIDTH / 2),y:  MyConstant.MREC_AD_HEIGHT,width: Double(MyConstant.MREC_AD_WIDTH),height: MyConstant.MREC_AD_HEIGHT))
        view.addSubview(adview)

        do{
            try        sdk.addAdView(to: adview, withOptions: nil, placementID: MyConstant.mrecPlacement)
            updateButtonState(button: MyMrecPlayBtn, enabled: false)
        }catch{
            print("Error encountered playing ad: %@", error);
            updateButtonState(button: MyMrecPlayBtn, enabled: true)
        }
        disablePlayLoadButtonsWithoutInitBtn()
        
    }
    @IBAction func OnClickMrecCloseButton(_ sender: Any) {
        sdk.finishDisplayingAd(MyConstant.mrecPlacement)
        updateButtonState(button: MyMrecCloseBtn, enabled: false)
        
    }
    @IBAction func OnClickBannerLoadButton(_ sender: Any) {
        do {
            try  sdk.loadPlacement(withID: MyConstant.bannerPlacement, with: VungleAdSize.banner)
            updateButtonState(button: MyBannerLoadBtn, enabled: false)
            
        } catch {
            updateButtonState(button: MyBannerLoadBtn, enabled: true)
           print("Unable to load placement with reference ID %@:, Error %@", MyConstant.bannerPlacement, error)
            
           // or display a dialog
        }
    }
    @IBAction func OnClickBannerPlayButton(_ sender: Any) {
        
   
        getScreenDimension()
        let viewYAxis: CGFloat = screenHeight!-MyConstant.BANNER_AD_HEIGHT
        print("viewYAxis is %f",viewYAxis);
        adview = UIView.init(frame: CGRect(x: (screenWidth! / 2) - (MyConstant.BANNER_SHORT_AD_WIDTH / 2),y:  MyConstant.BANNER_AD_HEIGHT-20,width: MyConstant.BANNER_SHORT_AD_WIDTH,height: MyConstant.BANNER_AD_HEIGHT))
        view.addSubview(adview)

        do{
            try        sdk.addAdView(to: adview, withOptions: nil, placementID: MyConstant.bannerPlacement)
            updateButtonState(button: MyBannerPlayBtn, enabled: false)
        }catch{
            updateButtonState(button: MyBannerPlayBtn, enabled: true)
            print("Error encountered playing ad: %@", error);
        }
        disablePlayLoadButtonsWithoutInitBtn()
    }
    @IBAction func OnClickBannerCloseButton(_ sender: Any) {
        sdk.finishDisplayingAd(MyConstant.bannerPlacement)
        updateButtonState(button: MyBannerCloseBtn, enabled: false)
    }
   
    
    @IBAction func onClickGoNativeButton(_ sender: Any) {
        let nativeVC = NativeViewController()
        self.present(nativeVC, animated: true, completion: nil)
           
    }
    
    
    
    func getScreenDimension(){
        screenHeight = MyConstant.SCREEN_HEIGHT;
        screenWidth = MyConstant.SCREEN_WIDTH;
    }
    
    
    
    
    //pragma mark - VungleSDKDelegate Methods
    
    func vungleSDKDidInitialize() {
        print("vungleSDKDidInitialized")
        updateButtonState(button: MyInitButton, enabled: false)
        updateButtons()
        
    }
    func vungleSDKFailedToInitializeWithError(_ error: Error) {
        print("vungleSDKFailedToInitializeWithErrorError %@", error)
    }
    func vungleRewardUser(forPlacementID placementID: String?) {
        print("vungleRewardUser for PlacementID %@", placementID!)
    }
    func vungleDidCloseAd(forPlacementID placementID: String) {
        print("vungleDidCloseAd for PlacementID %@", placementID)
        updateButtons()
    }
    func vungleDidShowAd(forPlacementID placementID: String?) {
        print("vungleDidCloseAd for PlacementID %@", placementID!)
        if placementID == MyConstant.mrecPlacement{
            updateButtonState(button: MyMrecCloseBtn, enabled: true)
            updateButtonState(button: MyMrecLoadBtn, enabled: true)
            updateButtonState(button: MyMrecPlayBtn, enabled: false)

        }else if placementID == MyConstant.bannerPlacement{
            updateButtonState(button: MyBannerCloseBtn, enabled: true)
            updateButtonState(button: MyBannerLoadBtn, enabled: true)
            updateButtonState(button: MyBannerPlayBtn, enabled: false)
            
        }else if placementID == MyConstant.interstitialPlacement{
            updateButtonState(button: MyIntLoadBtn, enabled: true)
            updateButtonState(button: MyIntPlayBtn, enabled: false)
            
        }else if placementID == MyConstant.rewardPlacement{
            updateButtonState(button: MyRewardLoadBtn, enabled: true)
            updateButtonState(button: MyRewardPlayBtn, enabled: false)
            
        }
    }
    func vungleAdViewed(forPlacement placementID: String) {
        print("vungleAdViewed for PlacementID %@", placementID)
    }
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?, error: Error?) {
        if (placementID != nil) {
            if isAdPlayable {
                print("vungleAdPlayabilityUpdate isAdPlayable  with placementID %@", placementID as Any)
            }else{
                print("vungleAdPlayabilityUpdate is  Not AdPlayable  with placementID %@ with error: %@", placementID ?? "",error as Any)
            }
         updateButtons()
        }else{
            print("vungleAdPlayabilityUpdate is  Not AdPlayable  with placementID %@ with error: %@")
        }

        
    }
    func vungleWillCloseAd(forPlacementID placementID: String) {
        print("vungleWillCloseAd for PlacementID %@", placementID)
    }
    func vungleTrackClick(forPlacementID placementID: String?) {
        print("vungleTrackClick for PlacementID %@", placementID!)
    }
    func vungleWillShowAd(forPlacementID placementID: String?) {
        print("vungleWillShowAd for PlacementID %@", placementID!)
    }
    func vungleWillLeaveApplication(forPlacementID placementID: String?) {
        print("vungleWillLeaveApplication for PlacementID %@", placementID!)
    }
    
}
