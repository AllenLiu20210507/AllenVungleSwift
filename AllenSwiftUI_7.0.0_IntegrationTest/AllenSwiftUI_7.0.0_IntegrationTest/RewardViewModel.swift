//
//  RewardViewModel.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/18.
//

import UIKit
import SwiftUI
import Foundation
import vng_ios_sdk

class RewardViewModel: NSObject,ObservableObject,VungleRewardedDelegate {
    var rewardAd : VungleRewarded!
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
        rewardAd =  VungleRewarded(placementId: placementID)
        
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
        rewardAd.delegate = self
        rewardAd.load()
        self.adState = .loading
    }
    
    func playAd(){
        rewardAd.present(with: getKeyWindow()!)
    }
    
    private func getKeyWindow() -> UIViewController? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?.rootViewController
    }
    
    


    func rewardedAdDidLoad(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdDidLoad")
        self.adState = .loaded
    }

    func rewardedAdDidFailToLoad(_ rewarded: VungleRewarded, withError: VungleError) {
        print("[AllenTestApp Log] rewardedAdDidFailToLoad with error \(withError.localizedDescription)")
        self.adState = .failLoad
    }

    func rewardedAdWillPresent(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdWillPresent")
    }

    func rewardedAdDidPresent(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdDidPresent")
        self.adState = .playing
    }

    func rewardedAdDidFailToPresent(_ rewarded: VungleRewarded, withError: VungleError) {
        print("[AllenTestApp Log] rewardedAdDidFailToPresent with error \(withError.localizedDescription)")
        self.adState = .failPlay
    }

    func rewardedAdWillClose(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdWillClose")
    }

    func rewardedAdDidClose(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdDidClose")
        self.adState = .closed
    }

    func rewardedAdDidTrackImpression(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdDidTrackImpression")
    }

    func rewardedAdDidClick(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdDidClick")
    }

    func rewardedAdWillLeaveApplication(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdWillLeaveApplication")
    }

    func rewardedAdDidRewardUser(_ rewarded: VungleRewarded) {
        print("[AllenTestApp Log] rewardedAdDidRewardUser")
    }

}
