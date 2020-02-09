//
//  TimelineController.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class TimelineController: UIViewController{
    
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    
    override func viewDidLoad() {
        
        let current = itemGen as! Item
        if (Double(current.price as! String) == 5.04) {
            l1.text = "\u{2022} Carbon footprint: " + (timelineTwix1.carbFootPrint as! String)  + "\n" + "\u{2022} Origin: " + (timelineTwix1.origin as! String) + "\n" + "\u{2022} Transport: " + (timelineTwix1.transport as! String) + "\n" + "\u{2022} Seller: " + (timelineTwix1.seller as! String) + "\n"
                       l2.text = "\u{2022} Carbon footprint: " + (timelineTwix2.carbFootPrint as! String) + "\n" + "\u{2022} Origin: " + (timelineTwix2.origin as! String) + "\n" + "\u{2022} Transport: " + (timelineTwix2.transport as! String) + "\n" + "\u{2022} Seller: " + (timelineTwix2.seller as! String) + "\n"
                       l3.text = "\u{2022} Carbon footprint: " + (timelineTwix3.carbFootPrint as! String) + "\n" + "\u{2022} Origin: " + (timelineTwix3.origin as! String) + "\n" + "\u{2022} Transport: " + (timelineTwix3.transport as! String) + "\n" + "\u{2022} Seller: " + (timelineTwix3.seller as! String) + "\n"
                       l4.text = "\u{2022} Carbon footprint: " + (timelineTwix4.carbFootPrint as! String) + "\n" + "\u{2022} Origin: " + (timelineTwix4.origin as! String) + "\n" + "\u{2022} Transport: " + (timelineTwix4.transport as! String) + "\n" + "\u{2022} Seller: " + (timelineTwix4.seller as! String) + "\n"
        } else if (Double(current.price as! String) == 2.00) {
            //grape
        } else if (Double(current.price as! String) == 0.44) {
            //custard
        } else if (Double(current.price as! String) == 1.28) {
            //pasta
        }
    }
    
    
}
