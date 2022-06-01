//
//  RewardView.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/18.
//

import SwiftUI

struct RewardView: View {
    @StateObject private var rewardVM = RewardViewModel()
    var body: some View {
        VStack{
            Text("Rewarded:  "+rewardVM.placementID)
                .foregroundColor(Color.orange).padding()
            Button(self.rewardVM.buttonText) {
                self.rewardVM.buttonAction()
            }.padding()
        }
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
