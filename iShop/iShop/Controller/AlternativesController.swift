//
//  AlternativesController.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class AlternativesController: UIViewController {
    
    @IBOutlet var cheapView: UIView!
    @IBOutlet var carbonView: UIView!
    @IBOutlet var healthView: UIView!
    
    @IBOutlet weak var cleanTitle: UILabel!
    @IBOutlet weak var cleanCalories: UILabel!
    @IBOutlet weak var cleanCarbon: UILabel!
    @IBOutlet weak var cleanPrice: UILabel!
    @IBOutlet weak var cleanImage: UIImageView!
    
    @IBOutlet weak var healthTitle: UILabel!
    @IBOutlet weak var healthCalories: UILabel!
    @IBOutlet weak var healthCarbon: UILabel!
    @IBOutlet weak var healthPrice: UILabel!
    @IBOutlet weak var healthImage: UIImageView!
    
    @IBOutlet weak var cheapTitle: UILabel!
    @IBOutlet weak var cheapCalories: UILabel!
    @IBOutlet weak var cheapCarbon: UILabel!
    @IBOutlet weak var cheapPrice: UILabel!
    @IBOutlet weak var cheapImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let current = itemGen as! Item
        let lowCal = current.lowCalAlt as! Alternative
        let lowCarb = current.lowCarbFootPrintAlt as! Alternative
        let lowPrice = current.cheaperAlt as! Alternative
        
        cleanTitle.text = (lowCarb.name as! String)
        cleanCalories.text = "Calories: " + (lowCarb.calories as! String)
        cleanCarbon.text = "Carbon Footprint: " + (lowCarb.carbonFootPrint as! String)
        cleanPrice.text = "Price: " + (lowCarb.price as! String)
        cleanImage.image = (lowCarb.URL as! UIImage)
        
        healthTitle.text = (lowCal.name as! String)
        healthCalories.text = "Calories: " + (lowCal.calories as! String)
        healthCarbon.text = "Carbon Footprint: " + (lowCal.carbonFootPrint as! String)
        healthPrice.text = "Price: " + (lowCal.price as! String)
        healthImage.image = (lowCal.URL as! UIImage)
        
        cheapTitle.text = (lowPrice.name as! String)
        cheapCalories.text = "Calories: " + (lowPrice.calories as! String)
        cheapCarbon.text = "Carbon Footprint: " + (lowPrice.carbonFootPrint as! String)
        cheapPrice.text = "Price: " + (lowPrice.price as! String)
        cheapImage.image = (lowPrice.URL as! UIImage)
        
        self.carbonView.frame = CGRect(x: 0, y: 64
            , width: self.view.frame.width, height: (self.view.frame.height - 64) / 3)
        self.view.addSubview(carbonView)
        
        self.cheapView.frame = CGRect(x: 0, y: 64 + (self.view.frame.height-64) / 3, width: self.view.frame.width, height: (self.view.frame.height - 64) / 3)
        self.view.addSubview(cheapView)
        
        var a = self.view.frame.height - 64
        a = a / 3 * 2 + 64
        
        self.healthView.frame = CGRect(x: 0, y: a, width: self.view.frame.width, height: (self.view.frame.height - 64) / 3)
        self.view.addSubview(healthView)
        
        
    }
}
