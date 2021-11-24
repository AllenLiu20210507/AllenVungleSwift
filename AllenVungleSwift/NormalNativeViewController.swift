////
////  NormalNativeViewController.swift
////  AllenVungleSwift
////
////  Created by allen.liu on 2021/11/23.
////
//
//import UIKit
//
//class NormalNativeViewController: UIViewController,VungleNativeAdDelegate {
//    @IBOutlet weak var iconView: UIImageView!
//    @IBOutlet weak var vungleMediaView: VungleMediaView!
//    @IBOutlet weak var rateNumberLabel: UILabel!
//    @IBOutlet weak var bodyTextLabel: UILabel!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var ctaButton: UIButton!
//    @IBOutlet weak var sponsoredByLabel: UILabel!
//    var vungleNativeAd: VungleNativeAd!
//    var loadingView: UIActivityIndicatorView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.loadingView = UIActivityIndicatorView (style:UIActivityIndicatorView.Style.large)
//        self.loadingView.startAnimating()
//             if self.loadingView.isAnimating {
//                 print("在动")
//             }else {
//                 print("不再动")
//             }
//        self.loadingView.center = CGPoint(x: 100.0, y: 200.0);
//        self.loadingView.color = UIColor.blue;
//        self.view.addSubview(self.loadingView)
//        self.vungleNativeAd = VungleNativeAd(placementID:MyConstant.nativePlacement)
//        self.vungleNativeAd.delegate = self
//        self.vungleNativeAd.load()
//        // Do any additional setup after loading the view.
//    }
//
//
//
//    func cleanupTextFields(){
//        self.titleLabel.text = "<app name>"
//        self.bodyTextLabel.text = "<app description>"
//        self.sponsoredByLabel.text = "<sponsored by>"
//        self.rateNumberLabel.text = "<app rating value>"
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    @IBAction func onClickLoadNative(_ sender: Any) {
//        self.loadingView.startAnimating()
//        self.view.addSubview(self.loadingView)
//
//    }
//
//    @IBAction func onClickDestroyNative(_ sender: Any) {
//        self.loadingView.stopAnimating()
//        self.loadingView.removeFromSuperview()
//        cleanupTextFields()
//    }
//    @IBAction func onClickCtaButton(_ sender: Any) {
//        self.loadingView.stopAnimating()
//        self.loadingView.removeFromSuperview()
//    }
//
//    //pragma mark - VungleNativeAdDelegate Methods
//
//    func nativeAdDidLoad(_ nativeAd: VungleNativeAd) {
//        self.loadingView.stopAnimating()
//        self.loadingView.removeFromSuperview()
//        print("nativeAdDidLoad",nativeAd)
//        let rate = nativeAd.adStarRating
//        titleLabel.text = nativeAd.title
//        rateNumberLabel.text =    NSString( format: "%ld", rate ) as String
//        bodyTextLabel.text = nativeAd.bodyText
//        iconView.image = nativeAd.iconImage
//        sponsoredByLabel.text = nativeAd.sponsoredText
//
//        // Set all UIViews as "clickable"
//
////        var clickableViews:Array<UIView> = [self.iconView,self.vungleMediaView,self.titleLabel,self.bodyTextLabel]
//        self.vungleNativeAd.registerView(forInteraction: self.titleLabel, mediaView: self.vungleMediaView, iconImageView: self.iconView,viewController: self)
////        [self.nativeAd registerViewForInteraction:self.adUIView
////                                        mediaView:self.adMediaView
////                                    iconImageView:self.adIconImageView
////                                   viewController:self
////                                   clickableViews:clickableViews];
//
//
//    }
//    func nativeAdDidTrackImpression(_ nativeAd: VungleNativeAd) {
//        self.loadingView.stopAnimating()
//        self.loadingView.removeFromSuperview()
//        print("nativeAdDidTrackImpression",nativeAd)
//    }
//    func nativeAd(_ nativeAd: VungleNativeAd, didFailWithError error: Error) {
//        self.loadingView.stopAnimating()
//        self.loadingView.removeFromSuperview()
//        print("didFailWithError",error)
//    }
//    func nativeAdDidClick(_ nativeAd: VungleNativeAd) {
//        print("didFailWithError",nativeAd)
//    }
//    func nativeAd(_ nativeAd: VungleNativeAd, didFailToPlayWithError error: Error) {
//        self.loadingView.stopAnimating()
//        self.loadingView.removeFromSuperview()
//        print("didFailToPlayWithError",error)
//    }
//
//}
