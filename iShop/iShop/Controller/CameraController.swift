//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit

class QRScannerViewController: UIViewController {
    
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

    public var item = Item(
        nutrients : "",
        lowCarbAlt : "",
        name : "",
        price : "",
        lowFatAlt : "",
        lowCalAlt : "",
        imageURL : ""
    )
 
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
    
    @IBAction func loadAlternativesView(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AlternativesController") as! AlternativesController
        newViewController.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    
    func displayItem(item: Item){
        self.scannerView.addSubview(self.itemview)
        self.addToCartButton.layer.cornerRadius = 20
        self.alternativesButton.layer.cornerRadius = 20
        self.itemview.center = self.view.center
        self.itemview.center.y -= 70
        self.itemview.layer.cornerRadius = 25
        view.bringSubviewToFront(itemview)
        
        self.itemName.text = (item.name as! String)
//        self.itemPrice.text = "£" + (item.price as! String)
//        setImage(from: item.imageURL as! String)
        self.item = item
    }
    
    @IBAction func addToCart(_ sender: Any) {
        addItemToCart(item: self.item)
        itemview.removeFromSuperview()
    }
    
    @IBAction func alternatives(_ sender: Any) {
        itemview.removeFromSuperview()
    }
    
    func addItemToCart(item: Item){
        fadeViewInThenOut(label: message, delay: TimeInterval(3))
        // [ADD ITEM TO LOCAL DATA]
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
        HTTPsendRequest(upcCode: qrData!.codeString!)
        scannerView.stopScanning()
        while (!isResult) {}
        print(result["nutrients"]!)
        let item : Item = parseData(nutrients: result["nutrients"]!, lowCarbAlt: result["lowCarbAlt"]!, name: result["name"]!, price: result["price"]!, lowFatAlt: result["lowFatAlt"]!, lowCalAlt: result["lowCalAlt"]!, imageURL: result["imageURL"]! )
        displayItem(item: item)

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
            self.result = jsonArray
            print(self.result)
            self.isResult = true

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
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.itemImage.image = image
            }
        }
    }


    
}
