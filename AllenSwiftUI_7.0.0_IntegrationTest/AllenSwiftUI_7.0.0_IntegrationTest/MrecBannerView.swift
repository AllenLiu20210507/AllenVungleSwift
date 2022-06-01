//
//  MrecBannerView.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/18.
//

import SwiftUI
import UIKit

struct MrecBannerView: View {
    @State private var selectedBannerSize = Configs().bannerSizes.first ?? .zero
    @StateObject private var bannerMrecVM = MrecViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
//            Text("Banner or Merc:  "+bannerMrecVM.placementId ?? default value)
//                .foregroundColor(Color.orange).padding()
            Text("Banner size: ")
            Picker("banner size picker", selection: $selectedBannerSize) {//Generic struct 'ForEach' requires that 'CGSize' conform to 'Hash
                ForEach(Configs().bannerSizes, id: \.self) {
                    Text("\(Int($0.width)) x \(Int($0.height))")// $0 return the GCSize's first para
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedBannerSize) { _ in
                self.bannerMrecVM.updateBannerSize(selectedBannerSize)
            }
            .onAppear {
                self.bannerMrecVM.updateBannerSize(selectedBannerSize)
            }
            .padding(.top, 10)

            Button(self.bannerMrecVM.buttonText) {
                self.bannerMrecVM.buttonAction()
            }
            .padding(.top, 20)
        }
        .padding([.leading, .trailing], 10)
        Spacer()
        VStack(alignment: .center, spacing: 0) {
            BannerContainer(vm: self.bannerMrecVM)
                .frame(width: self.selectedBannerSize.width,
                       height: self.selectedBannerSize.height,
                       alignment: Alignment.center)
                .background(.gray)
        }
    }
}

struct MrecBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MrecBannerView()
    }
}

struct BannerContainer: UIViewRepresentable {//UIViewRepresentable can convert UIKit into SwiftUI View, which means that we can build bridges through it, there are two protocols that must be implemented
    @ObservedObject var vm: MrecViewModel

    func makeUIView(context: Context) -> UIView {
//        print("[AllenTestApp Log] Making the UIView")
//        let bannerView = UIView(frame: .zero)
//        vm.bannerView = bannerView
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        vm.bannerView = uiView    //assign the updated uiview to the vm.bannerview
    }
}
