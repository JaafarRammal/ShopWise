//
//  CartController.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/8/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var total = 0.00
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var paypal: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!{
        didSet{
            self.checkoutButton.layer.cornerRadius = 20
        }
    }

    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBAction func cancelAction(_ sender: Any) {
        self.paypal.removeFromSuperview()
        self.tableView.alpha = 1
    }
    @IBOutlet weak var showCheckout: UIButton!
    @IBAction func showCheckout(_ sender: Any) {
        self.view.addSubview(paypal)
        self.paypal.center = self.view.center
        self.cancel.layer.cornerRadius = 20
        self.label.layer.cornerRadius = 20
        self.accept.layer.cornerRadius = 20
        self.paypal.layer.cornerRadius = 25
        self.tableView.alpha = 0.2
    }
    
    @IBAction func checkout(_ sender: UIButton) {
        cartItems = []
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
    var products : [Item] = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.rightBarButtonItem = self.navigationController?.navigationItem.backBarButtonItem
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        tableView.self.delegate = self
        tableView.self.dataSource = self
        total = 0.00
        for item in cartItems{
            print(item.price as! String)
            total +=  Double(item.price as! String) ?? 0.00
            products.append(item)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.totalLabel.text = "£\(total)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        let currentLastItem = products[indexPath.row]
        cell.itemIndex = indexPath.row
        cell.textLabel?.text = (currentLastItem.name as! String) + " (£\(currentLastItem.price as! String))"
        return cell

    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
}

