//
//  FeedsNativeViewController.swift
//  AllenVungleSwift
//
//  Created by allen.liu on 2021/11/25.
//

import UIKit

class FeedsNativeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,VungleNativeAdDelegate {
    
    @IBOutlet weak var feedsTabelView: UITableView!
    var vungleNativeAd: VungleNativeAd!
    var currentNativeAd: VungleNativeAd!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  50
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 364
    }

    
 

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("allen__tableView ",indexPath.row)
        print("allen__tableView ",currentNativeAd as Any)
        if indexPath.row%6==0 && indexPath.row != 0 && currentNativeAd != nil {
            var myCell:MyTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
            if myCell == nil {
                print("allen__myCell == nil",indexPath.row)
                myCell = MyTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "MyTableViewCell")
            }
                let rate = currentNativeAd.adStarRating
                myCell.myCellTitle.text = currentNativeAd.title
                let ratestring:String = NSString(format: "%.2f" , rate) as String
                myCell.myCellRate.text = ratestring
                myCell.myCellBody.text = currentNativeAd.bodyText
                myCell.myCellIconView.image = currentNativeAd.iconImage
                myCell.myCellSpon.text = currentNativeAd.sponsoredText
//                myCell.myCellCTABtn.addTarget(self, action:Selector(("showAlert")), for:.touchUpInside)
            
                // Set all UIViews as "clickable"

                let clickableViews:Array<UIView> = [myCell.myCellIconView,myCell.myCellVungleView,myCell.myCellTitle,myCell.myCellBody]

                self.vungleNativeAd.registerView(forInteraction: myCell.myCellIconView, mediaView: myCell.myCellVungleView, iconImageView: myCell.myCellIconView, viewController: self, clickableViews: clickableViews)
            print("allen__return myCell ",indexPath.row)
            return myCell
          
        }else{
            var scell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if scell == nil {
                print("allen__scell == nil",indexPath.row)
                 scell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
            }
            var str = "Allen Test  No ads Cell!!!! This is Row "
            let row:String = NSString(format: "%d" , indexPath.row) as String
            str.append(row)
            scell?.textLabel?.text = str
            print("allen__return sCell ",indexPath.row)
            return scell!
           
       }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feedsTabelView.register(UINib.init(nibName: "MyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MyTableViewCell")
        // Do any additional setup after loading the view.
        self.vungleNativeAd = VungleNativeAd(placementID:MyConstant.nativePlacement)
        self.vungleNativeAd.delegate = self
        self.vungleNativeAd.load()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    func showAlert(){

           let alert = UIAlertView(title: "Note", message: "You click the CTA button", delegate: self, cancelButtonTitle: "Swag!")

           alert.alertViewStyle = UIAlertViewStyle.default

           alert.show()

       }

    //pragma mark - VungleNativeAdDelegate Methods

    func nativeAdDidLoad(_ nativeAd: VungleNativeAd) {
     
        print("allen__nativeAdDidLoad",nativeAd)
        self.currentNativeAd = nativeAd

    }
    func nativeAdDidTrackImpression(_ nativeAd: VungleNativeAd) {
    
        print("allen__nativeAdDidTrackImpression",nativeAd)
    }
    func nativeAd(_ nativeAd: VungleNativeAd, didFailWithError error: Error) {
      
        print("allen__didFailWithError",error)
    }
    func nativeAdDidClick(_ nativeAd: VungleNativeAd) {
        print("allen__didFailWithError",nativeAd)
    }
    func nativeAd(_ nativeAd: VungleNativeAd, didFailToPlayWithError error: Error) {
     
        print("allen__didFailToPlayWithError",error)
    }

}
