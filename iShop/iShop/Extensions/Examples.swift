//
//  Examples.swift
//  iShop
//
//  Created by Clara Lebbos on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import Foundation

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

let twixAltCal : Alternative = Alternative(name : "Bear Pure Fruit Yoyo Strawberry 9 Pack", price : "3.00", URL : "https://images-na.ssl-images-amazon.com/images/I/61Xeh3tgRGL._AC_SX679_.jpg", carbonFootPrint : "C", calories : "365.2kcal")

let twixAltCarbFootPrint : Alternative = Alternative(name : "Tony's Chocolonely", price : "2.69", URL : "https://duetogsaij514.cloudfront.net/images/products/11/LN_673266_BP_11.jpg", carbonFootPrint : "B", calories : "465.2kcal")

let twixAltCheap : Alternative = Alternative(name : "Mcvities Penguin Milk Chocolate Biscuit 8 Pack 196.8G", price : "1.59", URL : "https://images-na.ssl-images-amazon.com/images/I/41SqOqztSWL._SX425_.jpg", carbonFootPrint : "C", calories : "510.2kcal")

let twixNutrients : Nutrients = Nutrients(CHOCDF: "64.7g", ENERC_KCAL: "495.6kcal", FAT: "23.9g", PROCNT: "4.3g", PORTION : "151g")

let twix : Item = Item(nutrients : twixNutrients, name : "TWIX® Twix biscuit fingers, 9 pack", price : "5.04", imageURL : "https://images-na.ssl-images-amazon.com/images/I/5101IMdFVSL.jpg", carbonFootPrint : "D", vegetarian : true, vegan : false, lowCalAlt : twixAltCal,  lowCarbFootPrintAlt : twixAltCarbFootPrint, cheaperAlt: twixAltCheap)


let grapeAltCal : Alternative = Alternative(name : "Suntrail Farms Kiwi X6", price : "0.59", URL : "https://digitalcontent.api.tesco.com/v2/media/ghs/2bff9f37-7604-4a62-b15a-25bfcdba9585/snapshotimagehandler_892024790.jpeg?h=540&w=540", carbonFootPrint : "B", calories : "61kcal")

let grapeCarbFootPrint : Alternative = Alternative(name : "Tesco British Apple Minimum 5 Pack", price : "1.60", URL : "https://digitalcontent.api.tesco.com/v2/media/ghs/1fb8a4e5-9aea-45ab-8a38-7658e79a43ff/snapshotimagehandler_1477811923.jpeg?h=540&w=540", carbonFootPrint : "B", calories : "52.2kcal")

let grapeCheap : Alternative = Alternative(name : "Jaffa Clementine Or Sweet Easy Peeler", price : "1.59", URL : "https://digitalcontent.api.tesco.com/v2/media/ghs/8948348c-778e-48b6-ae98-75f096ed5139/edeacdce-9ba0-4d38-9afc-980346bd122c.jpeg?h=540&w=540", carbonFootPrint : "B", calories : "47.2kcal")

let grapeNutrients : Nutrients = Nutrients(CHOCDF: "27.3g", ENERC_KCAL: "104kcal", FAT: "0.2g", PROCNT: "0g", PORTION : "100g")


let grape : Item = Item(nutrients : grapeNutrients, name : "Tesco Red Seedless Grapes Punnet 500G", price : "2.00", imageURL : "https://img.tesco.com/Groceries/pi/140/0000010066140/IDShot_540x540.jpg", carbonFootPrint : "B", vegetarian : true, vegan : false, lowCalAlt : grapeAltCal,  lowCarbFootPrintAlt : grapeCarbFootPrint, cheaperAlt: grapeCheap)


let custardCreamsAltCal : Alternative = Alternative(name : "Belvita Breakfast Milk & Cereals", price : "2.00", URL : "https://d1ycl3zewbvuig.cloudfront.net/images/products/11/LN_505005_BP_11.jpg", carbonFootPrint : "C", calories : "402kcal")

let custardCreamsCarbFootPrint : Alternative = Alternative(name : "Tony's Chocolonely", price : "2.69", URL : "https://duetogsaij514.cloudfront.net/images/products/11/LN_673266_BP_11.jpg", carbonFootPrint : "B", calories : "465.2kcal")


let custardCreamsCheap : Alternative = Alternative(name : "Tesco Rich Tea Biscuit 300G", price : "1.19", URL : "https://digitalcontent.api.tesco.com/v2/media/ghs/b7412201-3430-4c8b-870e-d96ba6bf9185/snapshotimagehandler_1354052235.jpeg?h=540&w=540", carbonFootPrint : "B", calories : "378kcal")


let custardCreamsNutrients : Nutrients = Nutrients(CHOCDF: "70.1g", ENERC_KCAL: "490kcal", FAT: "20.5g", PROCNT: "5.7g", PORTION : "100g")


let custardCreams : Item = Item(nutrients : custardCreamsNutrients, name : "Tesco Custard Creams", price : "0.44", imageURL : "https://digitalcontent.api.tesco.com/v2/media/ghs/09ec5b6c-f03d-443f-93b2-ee2e6a1b37e2/snapshotimagehandler_719569796.jpeg?h=540&w=540", carbonFootPrint : "C", vegetarian : true, vegan : false, lowCalAlt : custardCreamsAltCal,  lowCarbFootPrintAlt : custardCreamsCarbFootPrint, cheaperAlt: custardCreamsCheap)
