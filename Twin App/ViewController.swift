//
//  ViewController.swift
//  Twin App
//
//  Created by Anubhav Das on 16/05/21.
//

import UIKit
import GoogleMobileAds


class ViewController: UIViewController, GADFullScreenContentDelegate {

    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    private var interstitial: GADInterstitialAd?
    
    var imgArr = [  UIImage(named:"Hogwarts"),
                    UIImage(named:"Beast2") ,
                    UIImage(named:"Narnia1") ,
                    UIImage(named:"StarWars1") ,
                    UIImage(named:"XMEN1") ,
                    UIImage(named:"DC2") ,
                    UIImage(named:"Beast1"),
                    UIImage(named:"DC1") ,
                    UIImage(named:"Narnia2") ,
                    UIImage(named:"StarWars2") ,
                    UIImage(named:"XMEN2") ]
    
    var timer = Timer()
    var counter = 0
    
    let attrs = [
        NSAttributedString.Key.foregroundColor: UIColor.systemYellow,
        NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 32)!
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.4, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-9380433513141009/9406862052",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                interstitial?.fullScreenContentDelegate = self
                              }
            )
        
        
    }
    
    @objc func changeImage() {
     
     if counter < imgArr.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageView.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageView.currentPage = counter
         counter = 1
     }
         
     }
    
    // MARK: - Button Connectors
    
    
    @IBAction func `continue`(_ sender: UIButton) {
        
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
              } else {
                print("Ad wasn't ready")
              }
        
        let sec1:CameraViewController = self.storyboard?.instantiateViewController(withIdentifier: "sec1") as! CameraViewController
        
        sec1.shareIMG = "DC1"
        sec1.shareIMG2 = "DC2"
        sec1.shareLabel = "Steppenwolf and his Parademons return after eons to capture Earth. However, Batman seeks the help of Wonder Woman to recruit and assemble Flash, Cyborg and Aquaman to fight the powerful new enemy. Characters: Aquaman, Batman, Superman, Wonder Woman, Flash, Victor Stone."
        sec1.shareML = "DC1"
        self.navigationController?.pushViewController(sec1, animated: true)
    }
    
    @IBAction func `continue2`(_ sender: UIButton) {
        
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
              } else {
                print("Ad wasn't ready")
              }
        
        let sec1:CameraViewController = self.storyboard?.instantiateViewController(withIdentifier: "sec1") as! CameraViewController
        
        sec1.shareIMG = "XMEN2"
        sec1.shareIMG2 = "XMEN1"
        sec1.shareLabel = "After a mishap, Jean Grey is struck by a powerful ray of energy which she absorbs into her body, turning her into an uncontrollable liability for the X-Men. Characters: Wolverine, Storm, Raven, Professor X, Erik, Jean, Flash, Cyclops, Beast."
        sec1.shareML = "X1"
        self.navigationController?.pushViewController(sec1, animated: true)
    }
    
    @IBAction func `continue3`(_ sender: UIButton) {
        
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
              } else {
                print("Ad wasn't ready")
              }
        
        let sec1:CameraViewController = self.storyboard?.instantiateViewController(withIdentifier: "sec1") as! CameraViewController
        
        sec1.shareIMG = "Beast2"
        sec1.shareIMG2 = "Beast1"
        sec1.shareLabel = "Gellert Grindelwald plans to raise an army of wizards to rule over non-magical beings. In response, Newt Scamander's former professor, Albus Dumbledore, seeks his help to stop him. Characters: Dumbledore, Grindelwald, Newt, Credence, Porpentina, Queenie, Nagini, Leta, Theseus, Jacob."
        sec1.shareML = "FB1"
        self.navigationController?.pushViewController(sec1, animated: true)
    }
    
    @IBAction func `continue4`(_ sender: UIButton) {
        
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
              } else {
                print("Ad wasn't ready")
              }
        
        let sec1:CameraViewController = self.storyboard?.instantiateViewController(withIdentifier: "sec1") as! CameraViewController
        
        sec1.shareIMG = "Narnia1"
        sec1.shareIMG2 = "Narnia2"
        sec1.shareLabel = "While playing, Lucy and her siblings find a wardrobe that lands them in a mystical place called Narnia. Here they realise that it was fated and they must now unite with Aslan to defeat an evil queen. Characters: Aslan, Susan, Lucy, Lucy, Edmund, Prince Caspian, White Witch, Eustace, Mr. Tumnus."
        sec1.shareML = "Narnia1"
        self.navigationController?.pushViewController(sec1, animated: true)
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
     func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
       print("Ad did fail to present full screen content.")
     }

     /// Tells the delegate that the ad presented full screen content.
     func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did present full screen content.")
     }

     /// Tells the delegate that the ad dismissed full screen content.
     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did dismiss full screen content.")
     }
    
    
}




extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
