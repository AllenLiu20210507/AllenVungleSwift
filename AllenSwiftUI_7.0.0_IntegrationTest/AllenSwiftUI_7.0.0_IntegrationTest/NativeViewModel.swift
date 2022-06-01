//
//  NativeViewModel.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/23.
//

import UIKit
import Foundation
import vng_ios_sdk
import SwiftUI


class NativeViewModel: NSObject,ObservableObject,VungleNativeDelegate {
    @Published var targetedState: AdState = .new

    var nativeAd = VungleNative(placementId: Configs().NativePid)

    weak var itemView: NativeView?

    var buttonText: String {
        switch self.targetedState {
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
        switch self.targetedState {
        case .new:
            self.loadAd()
        case .loading:
            break
        case .loaded:
            self.playAd()
        case .failLoad:
            self.loadAd()
        case .playing:
            closeAd()
        case .failPlay:
            self.loadAd()
        case .closed:
            self.loadAd()
        }
    }

    func loadAd() {
        nativeAd.delegate = self
        nativeAd.load()
        self.targetedState = .loading
    }

    func playAd() {
        guard let adContainer = itemView, let controller = self.parentViewController(with: adContainer) else {
            closeAd()
            return
        }
        self.targetedState = .playing
        adContainer.nameLabel.text = nativeAd.title
        adContainer.ratingLabel.text = "Rating: \(nativeAd.adStarRating)"
        adContainer.sponLabel.text = nativeAd.sponsoredText
        adContainer.desLabel.text = nativeAd.bodyText
//        nativeAd.iconImage
        adContainer.ctaBtn.setTitle(nativeAd.callToAction, for: .normal)
        nativeAd.registerViewForInteraction(view: adContainer,
                                            mediaView: adContainer.mainImage,
                                            iconImageView: adContainer.icon,
                                            viewController: controller,
                                            clickableViews: [adContainer.icon, adContainer.nameLabel, adContainer.mainImage, adContainer.ctaBtn])
        itemView?.backgroundColor = .lightGray
    }

    func closeAd() {
        self.nativeAd.unregisterView()
        self.nativeAd = VungleNative(placementId: Configs().NativePid)
        itemView?.nameLabel.text = nil
        itemView?.ratingLabel.text = nil
        itemView?.sponLabel.text = nil
        itemView?.desLabel.text = nil
        itemView?.backgroundColor = .clear
        itemView?.ctaBtn.setTitle("", for: .normal)
        self.targetedState = .new
    }

    func parentViewController(with view: UIView) -> UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = view.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    func nativeAdDidLoad(_ native: VungleNative) {
        print("[AllenTestApp Log] nativeAdDidLoad")
        self.targetedState = .loaded
    }

    func nativeAdDidFailToLoad(_ native: VungleNative, withError: VungleError) {
        print("[AllenTestApp Log] nativeAdDidFailToLoad with error \(withError.localizedDescription)")
        self.targetedState = .failLoad
    }

    func nativeAdDidFailToPresent(_ native: VungleNative, withError: VungleError) {
        closeAd()
        print("[AllenTestApp Log] nativeAdDidFailToPresent with error \(withError.localizedDescription)")
        self.targetedState = .failPlay
    }

    func nativeAdDidTrackImpression(_ native: VungleNative) {
        print("[AllenTestApp Log] nativeAdDidTrackImpression")
        self.targetedState = .playing
    }

    func nativeAdDidClick(_ native: VungleNative) {
        print("[AllenTestApp Log] nativeAdDidClick")
    }
}
