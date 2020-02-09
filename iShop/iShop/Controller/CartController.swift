//
//  CartController.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/8/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct Product {
        var productName : String
        var producImage : UIImage
        var productDesc : String
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkoutButton: UIButton!{
        didSet{
            self.checkoutButton.layer.cornerRadius = 20
        }
    }

    @IBAction func checkout(_ sender: UIButton) {
        
    }
    
    let cellId = "cellId"
    var products : [Product] = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createProductArray()
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        tableView.self.delegate = self
        tableView.self.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        let currentLastItem = products[indexPath.row]
        cell.textLabel?.text = currentLastItem.productName
        return cell

    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func createProductArray() {
        products.append(Product(productName: "Chocolate" , producImage: #imageLiteral(resourceName: "green"), productDesc: "This is best Glasses I've ever seen"))
        products.append(Product(productName: "Desert", producImage: #imageLiteral(resourceName: "green"),productDesc: "This is so yummy"))
        products.append(Product(productName: "Food", producImage: #imageLiteral(resourceName: "green"),productDesc: "I wish I had this camera lens"))
        products.append(Product(productName: "Twix", producImage: #imageLiteral(resourceName: "green"),productDesc: "I wish I had this camera lens"))
    }
    
}

