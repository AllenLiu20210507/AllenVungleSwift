//
//  FullScreenNativeVC.swift
//  AllenVungleSwift
//
//  Created by allen.liu on 2021/11/29.
//

import UIKit

class FullScreenNativeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,VungleNativeAdDelegate {

    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    let kDataSourceCount:Int = 80
    var vungleNativeAd: VungleNativeAd!
    var currentNativeAd: VungleNativeAd!
    @IBOutlet weak var myTableView: UITableView!
    var currentIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpView()
        // Do any additional setup after loading the view.
    }
    
    
    
        //pragma mark - private methods 私有方法
    
    func setUpView(){
    
       
        self.myTableView.register(UINib.init(nibName: "MyFullTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MyFullTableViewCell")
        
        self.vungleNativeAd = VungleNativeAd(placementID:MyConstant.nativePlacement)
        self.vungleNativeAd.delegate = self
        self.vungleNativeAd.load()
        self.currentIndex = 0;

//
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.view addSubview:self.tableView];
//    //        self.data = self.awemes;
//            [self.tableView reloadData];
//
//            NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
//            [self.tableView scrollToRowAtIndexPath:curIndexPath atScrollPosition:UITableViewScrollPositionMiddle
//                                          animated:NO];
////            [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
//        });
//
 
            
        self.myTableView.scrollToRow(at: IndexPath(row: self.currentIndex, section: 0), at: UITableView.ScrollPosition.middle, animated: false)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func randomColor() -> UIColor{
        let hue: CGFloat = (CGFloat(arc4random() % 256) / 256.0 );
        let saturation: CGFloat = (CGFloat(arc4random() % 128) / 256.0 )+0.5;
        let brightness: CGFloat = (CGFloat(arc4random() % 128) / 256.0 )+0.5;

        return UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1);
    }

    //  - UIScrollView delegate
    
  
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y>0{
            self.navigationController!.navigationBar.isHidden = true;
        }
        else{
            self.navigationController!.navigationBar.isHidden = false;
        }
    }

    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
       
        DispatchQueue.main.async {
            var translatedPoint: CGPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
            scrollView.panGestureRecognizer.isEnabled = false
            print("allen__currentIndex  before ",self.currentIndex)
            print("allen__translatedPoint ",translatedPoint.y)
            if translatedPoint.y < -50  {
                self.currentIndex += 1   //向下滑动索引递增
            }
            if translatedPoint.y > 50 && self.currentIndex > 0  {
                self.currentIndex -= 1  //向上滑动索引递减
            }
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut) {
    //            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    //            self.myTableView.scrollToRow(at: NSIndexPath.init(row:self.currentIndex, section: 0) as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                

                self.myTableView.scrollToRow(at: IndexPath(row: self.currentIndex, section: 0), at: UITableView.ScrollPosition.top, animated: false)
            } completion: { Bool in
                scrollView.panGestureRecognizer.isEnabled = true;
            }
            print("allen__currentIndex  after ",self.currentIndex)
        }
     

    }
    
    // - UItableView delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("allen__tableView ",indexPath.row)
        print("allen__tableView ",currentNativeAd as Any)
        if indexPath.row%6==0 && indexPath.row != 0 && currentNativeAd != nil {
            var myCell:MyFullTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "MyFullTableViewCell") as! MyFullTableViewCell
            if myCell == nil {
                print("allen__myCell == nil",indexPath.row)
                myCell = MyFullTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "MyFullTableViewCell")
            }
//
            myCell.myFullCellBody.text = currentNativeAd.bodyText
            myCell.myFulliconCell.image = currentNativeAd.iconImage

            self.vungleNativeAd.registerView(forInteraction: myCell.myContentView, mediaView: myCell.myFullVungleMeidaCell, iconImageView: myCell.myFulliconCell, viewController: self)
            

            
            print("allen__return myCell ",indexPath.row)
            
            return myCell
          
        }else{
            var scell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if scell == nil {
                print("allen__scell == nil",indexPath.row)
                 scell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
            }
            var str = "Allen Test No ads FullScreen Cell!!!! This is Row "
            let row:String = NSString(format: "%d" , indexPath.row) as String
            str.append(row)
            scell?.textLabel?.text = str
            scell?.backgroundColor = randomColor()
            print("allen__return sCell ",indexPath.row)
            return scell!
           
       }
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kDataSourceCount
    }
    
    
    
    
    //pragma mark - VungleNativeAdDelegate Methods

    func nativeAdDidLoad(_ nativeAd: VungleNativeAd) {
     
        print("allen__nativeAdDidLoad",nativeAd)
        self.currentNativeAd = nativeAd

    }
    func nativeAdDidTrackImpression(_ nativeAd: VungleNativeAd) {
    
        print("allen__nativeAdDidTrackImpression",nativeAd)
    }
    func nativeAd(_ nativeAd: VungleNativeAd, didFailWithError error: Error) {
      
        print("allen__didFailWithError",error)
    }
    func nativeAdDidClick(_ nativeAd: VungleNativeAd) {
        print("allen__didFailWithError",nativeAd)
    }
    func nativeAd(_ nativeAd: VungleNativeAd, didFailToPlayWithError error: Error) {
     
        print("allen__didFailToPlayWithError",error)
    }

}
