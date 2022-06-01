//
//  ContentView.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import SwiftUI
import CoreData
import vng_ios_sdk
import AppTrackingTransparency

struct ContentView: View {
    

    var body: some View {
        
        ScrollView {
             VStack() {
               IntestitialView()
               Spacer()
               RewardView()
               Spacer()
               MrecBannerView()
               Spacer()
               NativeAdView()
            }
        }
    }


 
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
