//
//  CartController.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/8/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let userDefaults = UserDefaults.standard
    
    struct Product {
        var nutrients : Any
        var lowCarbAlt : Any
        var name : Any
        var price : Any
        var lowFatAlt : Any
        var lowCalAlt : Any
        var imageURL : Any
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkoutButton: UIButton!{
        didSet{
            self.checkoutButton.layer.cornerRadius = 20
        }
    }

    @IBAction func checkout(_ sender: UIButton) {
        userDefaults.set([], forKey: "Cart")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CameraController") as! QRScannerViewController
        newViewController.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    let cellId = "cellId"
    var products : [Product] = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.rightBarButtonItem = self.navigationController?.navigationItem.backBarButtonItem
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        tableView.self.delegate = self
        tableView.self.dataSource = self
        
//        userDefaults.set(["Test", "Hi", "Bye"], forKey: "Cart")

        var titles : [String] = userDefaults.array(forKey: "Cart") as! [String]
        for title in titles{
            let item = Product(
                nutrients : "",
               lowCarbAlt : "",
               name : title,
               price : "",
               lowFatAlt : "",
               lowCalAlt : "",
               imageURL : ""
           )
            products.append(item)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        let currentLastItem = products[indexPath.row]
        cell.textLabel?.text = (currentLastItem.name as! String)
        return cell

    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
}

