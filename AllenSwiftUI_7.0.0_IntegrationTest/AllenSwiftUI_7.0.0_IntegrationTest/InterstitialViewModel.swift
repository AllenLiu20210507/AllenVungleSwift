//
//  InterstitialViewModel.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import UIKit
import SwiftUI
import Foundation
import vng_ios_sdk

class InterstitialViewModel: NSObject,ObservableObject,VungleInterstitialDelegate {
    var interstitialAd : VungleInterstitial!
    let placementID = Configs().InsPid
   
    
    @Published var adState: AdState = .new
    
    
    var buttonText: String {
        switch self.adState {
      
        case .new:
            return "LoadAd"
        case .loading:
            return "Loading"
        case .loaded:
            return "PlayAd"
        case .failLoad:
            return "FailedLoad. LoadAd"
        case .playing:
            return "Playing"
        case .failPlay:
            return "FailedPlay. LoadAd"
        case .closed:
            return "LoadAd"
        }
    }
    
    
    
    override init() {
        interstitialAd =  VungleInterstitial(placementId: placementID)
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
            break
        case .failPlay:
            self.loadAd()
        case .closed:
            self.loadAd()
      
            
        }
    }
    func loadAd(){
        interstitialAd.load()
        interstitialAd.delegate = self
        self.adState = .loading
    }
    
    func playAd(){
        interstitialAd.present(with: getKeyWindow()!)
    }
    
    private func getKeyWindow() -> UIViewController? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?.rootViewController
    }
    
    


    func interstitialAdDidLoad(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdDidLoad")
        adState = .loaded
    }

    func interstitialAdDidFailToLoad(_ interstitial: VungleInterstitial, withError: VungleError) {
        print("[AllenTestApp Log] interstitialAdDidFailToLoad with error \(withError.localizedDescription)")
        adState = .failLoad
    }

    func interstitialAdWillPresent(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdWillPresent")
    }

    func interstitialAdDidPresent(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdDidPresent")
        adState = .playing
    }

    func interstitialAdDidFailToPresent(_ interstitial: VungleInterstitial, withError: VungleError) {
        print("[AllenTestApp Log] interstitialAdDidFailToPresent with error \(withError.localizedDescription)")
        self.adState = .failPlay
    }

    func interstitialAdWillClose(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdWillClose")
    }

    func interstitialAdDidClose(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdDidClose")
        self.adState = .closed
    }

    func interstitialAdDidTrackImpression(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdDidTrackImpression")
    }

    func interstitialAdDidClick(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdDidClick")
    }

    func interstitialAdWillLeaveApplication(_ interstitial: VungleInterstitial) {
        print("[AllenTestApp Log] interstitialAdWillLeaveApplication")
    }

}
