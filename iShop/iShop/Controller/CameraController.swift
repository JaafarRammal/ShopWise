//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit

class QRScannerViewController: UIViewController {
    
 
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var alternativesButton: UIButton!
    
    @IBOutlet var itemview: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var scanButtonIcon: UIImageView!
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }

    @IBAction func scanButtonAction(_ sender: UIButton) {
        scannerView.startScanning()
//        HTTPsendRequest()
        
    }
    
    func displayItem(code: String){
        print(code)
        self.scanButton.isHidden = true
        self.scanButtonIcon.isHidden = true
        self.scannerView.addSubview(self.itemview)
        self.addToCartButton.layer.cornerRadius = 20
        self.alternativesButton.layer.cornerRadius = 20
        self.itemview.center = self.view.center
        self.itemview.layer.cornerRadius = 25
        view.bringSubviewToFront(itemview)
        self.itemName.text = "Item Name!"
        self.itemPrice.text = "£" + "3"
    }
    
    @IBAction func addToCart(_ sender: Any) {
        itemview.removeFromSuperview()
        self.scanButton.isHidden = false
        self.scanButtonIcon.isHidden = false
    }
    
    @IBAction func alternatives(_ sender: Any) {
        itemview.removeFromSuperview()
        self.scanButton.isHidden = false
        self.scanButtonIcon.isHidden = false
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


