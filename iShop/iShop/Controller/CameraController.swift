//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit

class QRScannerViewController: UIViewController {
    
    struct Item {
        var name: String
        var price: String
        var image: UIImage?
    }
 
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var alternativesButton: UIButton!
    
    @IBOutlet var itemview: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var cartButton: UIButton!
    
    @IBOutlet weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    @IBOutlet weak var scanButton: UIButton!
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
//                self.qrData = nil
//                let code = String(qrData!.codeString!.split(separator: "-")[1])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
        message.alpha = 0
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
         navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func scanButtonAction(_ sender: UIButton) {
        scannerView.startScanning()
        print("bye?")
//        HTTPsendRequest()
    }
    
    @IBAction func loadCartView(_ sender: UIImageView) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CartController") as! CartController
        newViewController.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    
    func displayItem(code: String){
        print(code)
        self.scannerView.addSubview(self.itemview)
        self.addToCartButton.layer.cornerRadius = 20
        self.alternativesButton.layer.cornerRadius = 20
        self.itemview.center = self.view.center
        self.itemview.center.y -= 70
        self.itemview.layer.cornerRadius = 25
        view.bringSubviewToFront(itemview)
        self.itemName.text = "Item Name!"
        self.itemPrice.text = "£" + "3"
    }
    
    @IBAction func addToCart(_ sender: Any) {
        itemview.removeFromSuperview()
        let a = Item(name: "HI", price: "3")
        addItemToCart(item: a)
    }
    
    @IBAction func alternatives(_ sender: Any) {
        itemview.removeFromSuperview()
    }
    
    func addItemToCart(item: Item){
        fadeViewInThenOut(label: message, delay: TimeInterval(3))
    }
    
    func fadeViewInThenOut(label : UILabel, delay: TimeInterval) {

        let animationDuration = 0.25

        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            label.alpha = 1
            }) { (Bool) -> Void in

                // After the animation completes, fade out the view after a delay

                UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                    label.alpha = 0
                    },
                    completion: nil)
        }
    }
}

extension QRScannerViewController: QRScannerViewDelegate {
    func qrScanningDidStop() {

    }
    
    func qrScanningDidFail() {
        presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        self.qrData = QRData(codeString: str)
        displayItem(code: qrData!.codeString!)
        scannerView.stopScanning()
        qrData = nil
    }
    
}

func isValid(data: String, compare: [String]) -> Bool {
    if(compare.contains(data)){
        return true
    }
    return false
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}


