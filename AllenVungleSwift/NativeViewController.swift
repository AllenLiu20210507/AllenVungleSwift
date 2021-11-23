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

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onClickNormalNative(_ sender: Any) {
        NormalNativeViewController *nnativeVC = [[NormalNativeViewController alloc] init];
           [self presentViewController:nnativeVC animated:YES completion:nil];
        
    }
    
    @IBAction func onClickFeedsNative(_ sender: Any) {
        
    }
    
    @IBAction func onClickSplashNative(_ sender: Any) {
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
