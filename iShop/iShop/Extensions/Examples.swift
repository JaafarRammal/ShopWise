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


public struct Recipe {
    var healthLables : Any
    var imageURL : Any
    var ingerdients : Any
    var title : Any
    var URLSource : Any
}

public struct Timeline {
    var carbFootPrint : Any
    var origin : Any
    var transport : Any
    var seller : Any
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


let grape : Item = Item(nutrients : grapeNutrients, name : "Tesco Red Seedless Grapes", price : "2.00", imageURL : UIImage.init(named: "grapes")!, carbonFootPrint : "B", vegetarian : true, vegan : false, lowCalAlt : grapeAltCal,  lowCarbFootPrintAlt : grapeCarbFootPrint, cheaperAlt: grapeCheap)


let custardCreamsAltCal : Alternative = Alternative(name : "Belvita Breakfast Milk", price : "2.00", URL : UIImage.init(named: "belvita")!, carbonFootPrint : "C", calories : "402kcal")

let custardCreamsCarbFootPrint : Alternative = Alternative(name : "Tony's Chocolonely", price : "2.69", URL : UIImage.init(named: "tonys")!, carbonFootPrint : "B", calories : "465.2kcal")


let custardCreamsCheap : Alternative = Alternative(name : "Tesco Rich Tea Biscuit 300G", price : "1.19", URL : UIImage.init(named: "richBiscuit")!, carbonFootPrint : "B", calories : "378kcal")


let custardCreamsNutrients : Nutrients = Nutrients(CHOCDF: "70.1g", ENERC_KCAL: "490kcal", FAT: "20.5g", PROCNT: "5.7g", PORTION : "100g")


let custardCreams : Item = Item(nutrients : custardCreamsNutrients, name : "Tesco Custard Creams", price : "0.44", imageURL : UIImage.init(named: "custardCreams")!, carbonFootPrint : "C", vegetarian : true, vegan : false, lowCalAlt : custardCreamsAltCal,  lowCarbFootPrintAlt : custardCreamsCarbFootPrint, cheaperAlt: custardCreamsCheap)


let pastaAltCal : Alternative = Alternative(name : "Tesco Buckwheat Fusilli", price : "0.95", URL : "https://d1ycl3zewbvuig.cloudfront.net/images/products/11/LN_505005_BP_11.jpg", carbonFootPrint : "B", calories : "337kcal")

let pastaCarbFootPrint : Alternative = Alternative(name : "Tesco Red Lentil Fusilli", price : "1.35", URL : "https://duetogsaij514.cloudfront.net/images/products/11/LN_673266_BP_11.jpg", carbonFootPrint : "A", calories : "317kcal")


let pastaCheap : Alternative = Alternative(name : "Tesco Fusilli Pasta", price : "0.53", URL : "https://digitalcontent.api.tesco.com/v2/media/ghs/b7412201-3430-4c8b-870e-d96ba6bf9185/snapshotimagehandler_1354052235.jpeg?h=540&w=540", carbonFootPrint : "C", calories : "300kcal")


let pastaNutrients : Nutrients = Nutrients(CHOCDF: "72.0g", ENERC_KCAL: "356kcal", FAT: "20.5g", PROCNT: "12.0g", PORTION : "100g uncooked")


let pasta : Item = Item(nutrients : custardCreamsNutrients, name : "Napolina Fusilli", price : "1.28", imageURL : "https://digitalcontent.api.tesco.com/v2/media/ghs/09ec5b6c-f03d-443f-93b2-ee2e6a1b37e2/snapshotimagehandler_719569796.jpeg?h=540&w=540", carbonFootPrint : "C", vegetarian : true, vegan : false, lowCalAlt : pastaAltCal,  lowCarbFootPrintAlt : pastaCarbFootPrint, cheaperAlt: pastaCheap)

let recipe1 : Recipe = Recipe(healthLables: ["Peanut-Free","Tree-Nut-Free","Alcohol-Free"], imageURL: "https://www.edamam.com/web-img/16c/16c924e8828ad5ce80f4f63dc0f2a6dc.jpg", ingerdients: ["6 ounces mild italian sausage, cut into 1-inch chunks",
                                                                                                                                                                                               "1 tablespoon extra-virgin olive oil",
                                                                                                                                                                                               "1 small red onion, halved and thinly sliced",
                                                                                                                                                                                               "2 cloves garlic, chopped",
                                                                                                                                                                                               "1 tablespoon plus 1/4 teaspoon salt (preferably kosher), divided",
                                                                                                                                                                                               "2 cups seedless red grapes",
                                                                                                                                                                                               "1 cup low-sodium chicken broth",
                                                                                                                                                                                               "1/4 teaspoon red pepper flakes (or more to taste)",
                                                                                                                                                                                               "10 ounces whole-wheat orecchiette (or other short-cut pasta, such as farfalle or penne)",
                                                                                                                                                                                               "2 tablespoon grated parmesan",
                                                                                                                                                                                               "1/4 cup chopped fresh parsley (or 1/2 cup chopped fresh basil)"], title: "Pasta with Sausage and Red Grapes", URLSource: "http://www.epicurious.com/recipes/food/views/Pasta-with-Sausage-and-Red-Grapes-366833")


let recipe2 : Recipe = Recipe(healthLables: [ "Sugar-Conscious", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free"], imageURL: "https://www.edamam.com/web-img/458/4585bb846d4e9e599a14f8baaad88a94", ingerdients: ["1 small vine of purple grapes of choice",
"olive oil",
"salt",
"pepper",
"1 teaspoon minced fresh rosemary leaves (from 1/2 sprig of rosemary)",
"8 ounces dried pappardelle",
"1 shallot, peeled and minced",
"2 garlic cloves, peeled and minced",
"Pinch of red pepper flakes",
"1/4 cup creme fraiche",
"3 ounces sopressata (salami), diced",
"parmigiana-reggiano",
"fresh basil leaves"], title: "Grape and Sopressata Pasta recipes", URLSource: "http://www.pbs.org/food/fresh-tastes/grape-sopressata-pasta/")


let timelineCustard1 : Timeline = Timeline(carbFootPrint: "4.5", origin: "USA", transport: "Ship", seller: "Cindy's Sugar Factory")
let timelineCustard2 : Timeline = Timeline(carbFootPrint: "1.7", origin: "UK", transport: "Truck", seller: "Flourman")
let timelineCustard3 : Timeline = Timeline(carbFootPrint: "2.5", origin: "UK", transport: "Truck", seller: "Tesco Biscuit Factory")
let timelineCustard4 : Timeline = Timeline(carbFootPrint: "2.5", origin: "UK", transport: "Truck", seller: "Tesco Supermarket")

let timelineGrape1 : Timeline = Timeline(carbFootPrint: "0.1", origin: "South Africa", transport: "Truck", seller: "Bob Vineyard")
let timelineGrape2 : Timeline = Timeline(carbFootPrint: "4.3", origin: "South Africa", transport: "Ship", seller: "Fruits worldwide")
let timelineGrape3 : Timeline = Timeline(carbFootPrint: "2.3", origin: "UK", transport: "Truck", seller: "Tesco Warehouse")
let timelineGrape4 : Timeline = Timeline(carbFootPrint: "1.9", origin: "UK", transport: "Truck", seller: "Tesco Supermarket")

let timelinePasta1 : Timeline = Timeline(carbFootPrint: "0.1", origin: "Italy", transport: "Truck", seller: "Napolina")
let timelinePasta2 : Timeline = Timeline(carbFootPrint: "2.3", origin: "France" , transport: "Truck", seller: "Italian Supplier")
let timelinePasta3 : Timeline = Timeline(carbFootPrint: "4.3", origin: "UK" , transport: "Ship", seller: "Tesco Warehouse")
let timelinePasta4 : Timeline = Timeline(carbFootPrint: "1.7", origin: "UK" , transport: "Truck", seller: "Tesco Supermarket")

let timelineTwix1 : Timeline = Timeline(carbFootPrint: "0.2", origin: "Peru", transport: "Truck", seller: "Jeff's Cocoa Farm")
let timelineTwix2 : Timeline = Timeline(carbFootPrint: "4.5", origin: "USA" , transport: "Ship", seller: "Cindy's Sugar Factory")
let timelineTwix3 : Timeline = Timeline(carbFootPrint: "1.7", origin: "UK" , transport: "Truck", seller: "Flourman")
let timelineTwix4 : Timeline = Timeline(carbFootPrint: "1.9", origin: "UK" , transport: "Truck", seller: "Tesco Supermarket")
