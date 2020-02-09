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
public var item : Any = []

public struct Item {
    var nutrients : Any
    var name : Any
    var price : Any
    var imageURL : Any
    var carbonFootPrint : Any
    var vegetarian : Any
    var vegan : Any
    var lowCalAlt : Any
    var lowCarbFootPrintAlt : Any
    var cheaperAlt : Any
}

public struct Recipe {
    var healthLables : Any
    var imageURL : Any
    var ingerdients : Any
    var title : Any
    var URLSource : Any
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
        let code = qrData!.codeString!
        if (code == "5000159417426" || code == "10066140" || code == "5000119003034" || code == "5000184592402") {
            parseDataUPC(code : code)
            print(item)
            scannerView.stopScanning()
            print(item)
            HTTPsendRequestRecipe(ingredients: "pasta%20grapes")
            while(!isRecipeResult) {}
            print(recipeResult)
        } else {
        HTTPsendRequest(upcCode: qrData!.codeString!)!
        scannerView.stopScanning()
        while (!isResult) {}
        print(result["nutrients"]!)
            let item : Item = parseData(nutrients : result["nutrients"]!,
            name : result["name"]!,
            price : result["price"]!,
            imageURL : result["imageURL"]!,
            carbonFootPrint : "",
            vegetarian : "",
            vegan : "",
            lowCalAlt : result["lowCalAlt"]!,
            lowCarbFootPrintAlt :  result["lowCarbAlt"]!,
            cheaperAlt : "")
        }
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
           let jsonResponse = try JSONSerialization.jsonObject(with:
                                  dataResponse, options: [])
        guard let jsonArray = jsonResponse as? [String: Any] else {
            print("empty")
              return
        }
        result = jsonArray
        print(result)
        isResult = true

       } catch let parsingError {
           print("Error", parsingError)
      }
    }
    task.resume()
    return result
    
}

func parseData(nutrients : Any, name : Any, price : Any, imageURL : Any, carbonFootPrint : Any, vegetarian : Any, vegan : Any, lowCalAlt : Any, lowCarbFootPrintAlt :  Any, cheaperAlt : Any) -> Item {
    
    let item = Item(nutrients : nutrients, name : name, price : price, imageURL : imageURL, carbonFootPrint : carbonFootPrint, vegetarian : vegetarian, vegan : vegan, lowCalAlt : lowCalAlt, lowCarbFootPrintAlt :  lowCarbFootPrintAlt, cheaperAlt : cheaperAlt)
    return item
}

func parseDataUPC(code : String) {
    if (code == "5000159417426") {
        item = twix
    }
    else if (code == "10066140") {
        item = grape
    }
    else if (code == "5000184592402") {
        item = pasta
    }
    else {
        item = custardCreams
    }
}

public var isRecipeResult : Bool = false
public var recipeResult : [String: Any] = [:]

func HTTPsendRequestRecipe(ingredients:String) -> [String: Any]? {
    print("reached hererere")
    guard let url = URL(string: "https://ichack20.herokuapp.com/api/recipes/" + ingredients) else {print("hi")
        return [:]}
    print("reached hererere2")

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let dataResponse = data,
             error == nil else {
             print(error?.localizedDescription ?? "Response Error")
             return }
       do{
        print("reached herererdeféfaéefaée")

           let jsonResponse = try JSONSerialization.jsonObject(with:
                                  dataResponse, options: [])
        print(jsonResponse)
        guard let jsonArray = jsonResponse as? [String: Any] else {
            print("empty")
              return
        }
        recipeResult = jsonArray
        print(recipeResult)
        isRecipeResult = true
        parseRecipe(recipeResult: recipeResult)
        print("after reach")

       } catch let parsingError {
           print("Error", parsingError)
      }
    }
    task.resume()
    return recipeResult
    
}

func parseRecipe(recipeResult : [String: Any]?) -> Recipe {
    return recipe1
}
