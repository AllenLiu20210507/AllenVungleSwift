//
//  MrecViewModel.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/18.
//

import UIKit
import vng_ios_sdk

class MrecViewModel: NSObject,ObservableObject,VungleBannerDelegate {

    @Published var adState: AdState = .new
    var selectedBannerSize: CGSize = CGSize.zero
    var bannerView: UIView?
    var placementId:String?
    var bannerAd:VungleBanner?
    
    var buttonText: String {
        switch self.adState {
        case .new:
            return "LoadAd"
        case .loading:
            return "Loading..."
        case .loaded:
            return "PlayAd"
        case .failLoad:
            return "FailedLoad. LoadAd"
        case .playing:
            return "CloseAd"
        case .failPlay:
            return "FailedPlay. LoadAd"
        case .closed:
            return "LoadAd"
        }
    }

    func buttonAction() {
        switch self.adState {
        case .new:
            self.loadAd()
        case .loading:
            break
        case .loaded:
            self.playAd()
        case .failLoad:
            self.loadAd()
        case .playing:
            bannerView?.subviews.forEach({ $0.removeFromSuperview() })//remove all the subviews when it is
        case .failPlay:
            self.loadAd()
        case .closed:
            self.loadAd()
        }
    }

    func updateBannerSize(_ size: CGSize) {
        self.selectedBannerSize = size
        if Configs().isMrecSize(selectedBannerSize) {
            placementId = Configs().MrecPid
        }else{
            placementId = Configs().BannerPid
        }
        print("[AllenTestApp Log] Updating selected banner size to \(size)")
    }
    
    func loadAd() {
     
       
          
        bannerAd =  VungleBanner(placementId: placementId!, size: convertCGSizeToBannerSize())
        bannerAd!.delegate = self
        bannerAd?.load()
        
        self.adState = .loading
    }

    func playAd() {
//        guard let ad = self.adTracker[self.isBidding]?.ad else {
//            // The ad has not been loaded into the tracker yet.
//            return
//        }

        guard let bannerView = self.bannerView else {
            print("[AllenTestApp Log] Unable to present banner. View wasn't set.")
            return
        }
        bannerAd!.present(on: bannerView)
    }

    private func convertCGSizeToBannerSize()  -> BannerSize {
        switch self.selectedBannerSize {
        case CGSize(width: 320, height: 50):
            return .regular
        case CGSize(width: 300, height: 50):
            return .short
        case CGSize(width: 300, height: 250):
            return .mrec
        case CGSize(width: 728, height: 90):
            return .leaderboard
        default:
            print("[AllenTestApp Log] invalid size found.Use regular as default")
            return .regular
           
        }
    }
    func bannerAdDidLoad(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdDidLoad")
        self.adState = .loaded
    }

    func bannerAdDidFailToLoad(_ banner: VungleBanner, withError: VungleError) {
        print("[AllenTestApp Log] bannerAdDidFailToLoad with error \(withError.localizedDescription)")
        self.adState = .failLoad
    }

    func bannerAdWillPresent(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdWillPresent")
    }

    func bannerAdDidPresent(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdDidPresent")
        self.adState = .playing
    }

    func bannerAdDidFailToPresent(_ banner: VungleBanner, withError: VungleError) {
        print("[AllenTestApp Log] bannerAdDidFailToPresent with error \(withError.localizedDescription)")
        self.adState = .failPlay
    }

    func bannerAdWillClose(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdWillClose")
    }

    func bannerAdDidClose(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdDidClose")
        self.adState = .closed
    }

    func bannerAdDidTrackImpression(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdDidTrackImpression")
    }

    func bannerAdDidClick(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdDidClick")
    }

    func bannerAdWillLeaveApplication(_ banner: VungleBanner) {
        print("[AllenTestApp Log] bannerAdWillLeaveApplication")
    }
}
