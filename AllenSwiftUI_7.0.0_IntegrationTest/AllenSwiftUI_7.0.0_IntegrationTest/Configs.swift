//
//  Configs.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import Foundation
struct Configs {
    let appId = "5df09ea62c378d001251fb1d"
    let InsPid = "DEFAULT-8335742"
    let RewardPid = "ALLEN_RV_TEST-0723637"
    let MrecPid = ""
    let BannerPid = ""
    let NativePid = ""
}

enum AdState: Int {
    case new,loading,loaded,failLoad,playing,failPlay,closed
}
