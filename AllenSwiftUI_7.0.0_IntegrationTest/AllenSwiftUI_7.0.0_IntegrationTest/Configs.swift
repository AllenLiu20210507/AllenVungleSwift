//
//  Configs.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import Foundation
import SwiftUI
import UIKit

struct Configs {
    let appId = "5df09ea62c378d001251fb1d"
    let InsPid = "DEFAULT-8335742"
    let RewardPid = "ALLEN_RV_TEST-0723637"
    let MrecPid = "ALLEN_MREC_TEST-6031772"
    let BannerPid = "ALLEN_BANNER_TEST-1890316"
    let NativePid = "ALLEN_NATIVE_TEST-2262371"
    let bannerSizes = [
        CGSize(width: 320, height: 50),
        CGSize(width: 300, height: 50),
        CGSize(width: 300, height: 250), // mrec
        
    ]
    
    func isMrecSize(_ size: CGSize) -> Bool {
        return size.equalTo(CGSize(width: 300, height: 250))
    }
}

enum AdState: Int {
    case new,loading,loaded,failLoad,playing,failPlay,closed
}

extension CGSize: Hashable { //Generic struct 'ForEach' requires that 'CGSize' conform to 'Hash
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}


