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
            Text(intersitialVM.pid)
                .foregroundColor(Color.orange)
            Button(self.intersitialVM.buttonText) {
                self.intersitialVM.buttonAction()
            }
            
        }
      
    }
}


