//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit

public var isResult : Bool = false
public var result : [String: Any] = [:]

struct Item {
    var nutrients : Any
    var lowCarbAlt : Any
    var name : Any
    var price : Any
    var lowFatAlt : Any
    var lowCalAlt : Any
    var imageURL : Any
}



class QRScannerViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var attendees = [String]()
    
    @IBOutlet var itemview: UIView!
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }

    @IBAction func scanButtonAction(_ sender: UIButton) {
        scannerView.startScanning()
    }
    
    func displayItem(code: String){
        print(code)
        self.scannerView.addSubview(self.itemview)
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
        HTTPsendRequest(upcCode: qrData!.codeString!)!
        scannerView.stopScanning()
        while (!isResult) {}
        print(result["nutrients"]!)
        let item : Item = parseData(nutrients: result["nutrients"]!, lowCarbAlt: result["lowCarbAlt"]!, name: result["name"]!, price: result["price"]!, lowFatAlt: result["lowFatAlt"]!, lowCalAlt: result["lowCalAlt"]!, imageURL: result["imageURL"]! )
        print(item)
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

func HTTPsendRequest(upcCode:String) -> [String: Any]? {
    
guard let url = URL(string: "https://ichack20.herokuapp.com/api/ean/" + upcCode) else {return [:]}

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let dataResponse = data,
             error == nil else {
             print(error?.localizedDescription ?? "Response Error")
             return }
       do{
           //here dataResponse received from a network request
           let jsonResponse = try JSONSerialization.jsonObject(with:
                                  dataResponse, options: [])
    //        print(jsonResponse) //Response result
        guard let jsonArray = jsonResponse as? [String: Any] else {
            print("empty")
              return
        }
    //        print("here")
        result = jsonArray
        print(result)
        isResult = true

    //        print(result)
        } catch let parsingError {
           print("Error", parsingError)
      }
    }
    task.resume()
    return result
    
}

func parseData(nutrients : Any, lowCarbAlt : Any, name : Any, price : Any, lowFatAlt : Any, lowCalAlt : Any, imageURL : Any) -> Item {
    let item = Item(nutrients : nutrients, lowCarbAlt : lowCarbAlt, name : name, price : price, lowFatAlt : lowFatAlt, lowCalAlt : lowCalAlt, imageURL : imageURL)
    return item
}
