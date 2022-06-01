//
//  IntestitialView.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import SwiftUI

struct IntestitialView: View {
    @StateObject private var intersitialVM = InterstitialViewModel()
    var body: some View {
        VStack{
            Text("Interstitial:  "+intersitialVM.placementID)
                .foregroundColor(Color.orange).padding()
            Button(self.intersitialVM.buttonText) {
                self.intersitialVM.buttonAction()
            }
            .padding()
        
        }
      
    }
}


