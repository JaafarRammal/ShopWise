//
//  RecepiesController.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class RecepiesController: UIViewController{
    
    @IBOutlet weak var i2: UITextView!
    @IBOutlet weak var i1: UITextView!
    @IBOutlet weak var link1: UILabel!
    @IBOutlet weak var link2: UILabel!
    
    override func viewDidLoad() {
        for ingredient in (recipe1.ingerdients as! [String]){
            self.i2.text += "\u{2022} " + ingredient + "\n\n"
        }
        for ingredient in (recipe2.ingerdients as! [String]){
            self.i1.text += "\u{2022} " + ingredient + "\n\n"
        }
        
    }
    
    
}
