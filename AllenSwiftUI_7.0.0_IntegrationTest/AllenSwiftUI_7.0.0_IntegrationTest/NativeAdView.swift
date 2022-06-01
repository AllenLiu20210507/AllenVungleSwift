//
//  NativeAdView.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/23.
//

import SwiftUI
import vng_ios_sdk

struct NativeAdView: View {
  
    @StateObject private var nativeViewModel = NativeViewModel()
    
   
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("NativeAds:  "+Configs().NativePid)
                .foregroundColor(Color.orange).padding()
            Button(nativeViewModel.buttonText) {
                nativeViewModel.buttonAction()
            }
        }
        .padding([.leading, .trailing], 10)
        Native(vm: nativeViewModel)
            .frame(height: 360)
        
     
    }
}

struct NativeAdView_Previews: PreviewProvider {
    static var previews: some View {
        NativeAdView()
    }
}
    
struct Native: UIViewRepresentable {

        let vm: NativeViewModel

        func makeUIView(context: Context) -> UIView {
            print("[AllenTestApp Log] Making the Native UIView")
            let view = NativeView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            vm.itemView = view
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
        }
        
    }
    


class NativeView: UIView {

    let icon = UIImageView()
    let mainImage = UIImageView()
    let nameLabel = UILabel()
    let ratingLabel = UILabel()
    let sponLabel = UILabel()
    let desLabel = UILabel()
    let ctaBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutIcon(icon)
        layoutNameLabel(nameLabel)
        layoutRatingLabel(ratingLabel, below: nameLabel)
        layoutSponsorLabel(sponLabel, below: ratingLabel)
        layoutMainImageView(mainImage, below: icon)
        layoutDesLabel(desLabel, below: mainImage)
        layoutCtaBtn(ctaBtn)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutIcon(_ icon: UIImageView) {
        icon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
    }

    func layoutNameLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 72).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -6).isActive = true
    }

    func layoutRatingLabel(_ label: UILabel, below nameLabel: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -6).isActive = true
    }

    func layoutSponsorLabel(_ label: UILabel, below ratingLabel: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -6).isActive = true
    }

    func layoutMainImageView(_ view: UIImageView, below iconView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6).isActive = true
        view.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }

    func layoutDesLabel(_ label: UILabel, below mainImageView: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 6).isActive = true
        label.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: 6).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -6).isActive = true
    }

    func layoutCtaBtn(_ btn: UIButton) {
        btn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(btn)
        btn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
        btn.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: 6).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

}
