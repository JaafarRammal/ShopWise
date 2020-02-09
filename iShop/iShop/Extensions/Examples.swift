//
//  Examples.swift
//  iShop
//
//  Created by Clara Lebbos on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import Foundation
import UIKit

struct Nutrients {
    var CHOCDF : Any
    var ENERC_KCAL : Any
    var FAT : Any
    var PROCNT : Any
    var PORTION : Any
}

struct Alternative {
    var name : Any
    var price : Any
    var URL : Any
    var carbonFootPrint : Any
    var calories : Any
    
}

let twixAltCal : Alternative = Alternative(name : "Bear Pure Fruit Yoyo", price : "3.00", URL : UIImage.init(named: "bear")!, carbonFootPrint : "C", calories : "365.2kcal")

let twixAltCarbFootPrint : Alternative = Alternative(name : "Tony's Chocolonely", price : "2.69", URL : UIImage.init(named: "tonys")!, carbonFootPrint : "B", calories : "465.2kcal")

let twixAltCheap : Alternative = Alternative(name : "Mcvities Penguin Milk Chocolate", price : "1.59", URL : UIImage.init(named: "penguin")!, carbonFootPrint : "C", calories : "510.2kcal")

let twixNutrients : Nutrients = Nutrients(CHOCDF: "64.7g", ENERC_KCAL: "495.6kcal", FAT: "23.9g", PROCNT: "4.3g", PORTION : "151g")

let twix : Item = Item(nutrients : twixNutrients, name : "TWIX® Twix biscuit fingers, 9 pack", price : "5.04", imageURL : UIImage.init(named: "twix")!, carbonFootPrint : "D", vegetarian : true, vegan : false, lowCalAlt : twixAltCal,  lowCarbFootPrintAlt : twixAltCarbFootPrint, cheaperAlt: twixAltCheap)


let grapeAltCal : Alternative = Alternative(name : "Suntrail Farms Kiwi X6", price : "0.59", URL : UIImage.init(named: "kiwi")!, carbonFootPrint : "B", calories : "61kcal")

let grapeCarbFootPrint : Alternative = Alternative(name : "Tesco British Apple Minimum 5 Pack", price : "1.60", URL : UIImage.init(named: "apple")!, carbonFootPrint : "B", calories : "52.2kcal")

let grapeCheap : Alternative = Alternative(name : "Jaffa Clementine Or Sweet Easy Peeler", price : "1.59", URL : UIImage.init(named: "oranges")!, carbonFootPrint : "B", calories : "47.2kcal")

let grapeNutrients : Nutrients = Nutrients(CHOCDF: "27.3g", ENERC_KCAL: "104kcal", FAT: "0.2g", PROCNT: "0g", PORTION : "100g")


let grape : Item = Item(nutrients : grapeNutrients, name : "Tesco Red Seedless Grapes Punnet 500G", price : "2.00", imageURL : UIImage.init(named: "grapes")!, carbonFootPrint : "B", vegetarian : true, vegan : false, lowCalAlt : grapeAltCal,  lowCarbFootPrintAlt : grapeCarbFootPrint, cheaperAlt: grapeCheap)


let custardCreamsAltCal : Alternative = Alternative(name : "Belvita Breakfast Milk", price : "2.00", URL : UIImage.init(named: "belvita")!, carbonFootPrint : "C", calories : "402kcal")

let custardCreamsCarbFootPrint : Alternative = Alternative(name : "Tony's Chocolonely", price : "2.69", URL : UIImage.init(named: "tonys")!, carbonFootPrint : "B", calories : "465.2kcal")


let custardCreamsCheap : Alternative = Alternative(name : "Tesco Rich Tea Biscuit 300G", price : "1.19", URL : UIImage.init(named: "richBiscuit")!, carbonFootPrint : "B", calories : "378kcal")


let custardCreamsNutrients : Nutrients = Nutrients(CHOCDF: "70.1g", ENERC_KCAL: "490kcal", FAT: "20.5g", PROCNT: "5.7g", PORTION : "100g")


let custardCreams : Item = Item(nutrients : custardCreamsNutrients, name : "Tesco Custard Creams", price : "0.44", imageURL : UIImage.init(named: "custardCreams")!, carbonFootPrint : "C", vegetarian : true, vegan : false, lowCalAlt : custardCreamsAltCal,  lowCarbFootPrintAlt : custardCreamsCarbFootPrint, cheaperAlt: custardCreamsCheap)
