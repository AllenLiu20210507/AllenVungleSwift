//
//  NativeViewController.swift
//  AllenVungleSwift
//
//  Created by allen.liu on 2021/11/23.
//

import UIKit

class NativeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onClickNormalNative(_ sender: Any) {
     
        let nnativeVC = NormalNativeViewController()
        self.navigationController?.pushViewController(nnativeVC, animated: true)
    }
    
    
   
    @IBAction func onClickFeedsNative(_ sender: Any) {
        let fnativeVC = FeedsNativeViewController()
        self.navigationController?.pushViewController(fnativeVC, animated: true)
        
        
    }
    // fullscreen native
    @IBAction func onClickSplashNative(_ sender: Any) {
        let fnativeVC = FullScreenNativeVC()
        self.navigationController?.pushViewController(fnativeVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
