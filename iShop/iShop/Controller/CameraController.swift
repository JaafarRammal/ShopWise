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
    public var cartItems: [Item] = []

    public var isRecipeResult : Bool = false
    public var recipeResult : [String: Any] = [:]

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


   public var itemGen : Any = []


class QRScannerViewController: UIViewController {
    
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var alternativesButton: UIButton!
    
    @IBOutlet var itemview: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var feature1: UILabel!
    @IBOutlet weak var feature2: UILabel!
    @IBOutlet weak var feature3: UILabel!
    @IBOutlet weak var feature4: UILabel!
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cart: UIImageView!
    
    @IBOutlet weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    @IBOutlet var mainView: UIView!
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
    }
    
    
    
    @IBOutlet weak var book: UIImageView!
    @IBAction func loadFood(_ send:Any){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecepiesController") as! RecepiesController
        newViewController.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(newViewController, animated: false)
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
    
    @IBAction func loadTimeline(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TimelineController") as! TimelineController
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
        self.mainView.addSubview(self.itemview)
        self.scannerView.alpha = 0.5
        self.addToCartButton.layer.cornerRadius = 20
        self.alternativesButton.layer.cornerRadius = 20
        self.itemview.center = self.view.center
        self.itemview.layer.cornerRadius = 25
        view.bringSubviewToFront(itemview)
        
        self.itemName.text = (item.name as! String)
        self.itemPrice.text = "£" + (item.price as! String)
        self.itemImage.image = (item.imageURL as! UIImage)
        self.feature1.text = "Carbon FP: " + (item.carbonFootPrint as! String)
        self.feature2.text = "Calories: " + ((item.nutrients as! Nutrients).ENERC_KCAL as! String)
        self.feature3.text = "Fat: " + ((item.nutrients as! Nutrients).FAT as! String)
        self.feature4.text = "Vegeterian"
        itemGen = item
        self.circle.isHidden = true
        self.cart.isHidden = true
        self.book.isHidden = true
    }
    
    @IBAction func addToCart(_ sender: Any) {
        addItemToCart(item: itemGen as! Item)
        itemview.removeFromSuperview()
        self.circle.isHidden = false
        self.scannerView.alpha = 1
        self.cart.isHidden = false
        self.book.isHidden = false
    }
    
    @IBAction func alternatives(_ sender: Any) {
        itemview.removeFromSuperview()
        self.circle.isHidden = false
        self.scannerView.alpha = 1
        self.cart.isHidden = false
        self.book.isHidden = false
    }
    
    func addItemToCart(item: Item){
        cartItems.append(item)
        fadeViewInThenOut(label: message, delay: TimeInterval(3))
        // [ADD ITEM TO LOCAL DATA]
    }
    
    @IBAction func tap(_ sender: Any) {
        itemview.removeFromSuperview()
        self.circle.isHidden = false
        self.scannerView.alpha = 1
        self.cart.isHidden = false
        self.book.isHidden = false
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
        let code = qrData!.codeString!
        if (code == "5000159417426" || code == "10066140" || code == "5000119003034" || code == "5000184592402") {
            parseDataUPC(code : code)
            displayItem(item: itemGen as! Item)
            scannerView.stopScanning()
//            HTTPsendRequestRecipe(ingredients: "pasta%20grapes")
//            while(!isRecipeResult) {}
//            print(recipeResult)
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
            itemGen = twix
        }
        else if (code == "10066140") {
            itemGen = grape
        }
        else if (code == "5000184592402") {
            itemGen = pasta
        }
        else {
            itemGen = custardCreams
        }
    }



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
            self.parseRecipe(recipeResult: recipeResult)
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
}
