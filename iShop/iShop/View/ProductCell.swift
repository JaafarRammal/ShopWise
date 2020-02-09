//
//  ProductCell.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit

class ProductCell : UITableViewCell {
 
    var itemIndex: Int?
   
    @objc func tapDetected() {
        cartItems.remove(at: itemIndex!)
        print("Removed at \(itemIndex!)")

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        let delete = UIImageView()
        delete.image = UIImage(named: "x")
        delete.contentMode = .scaleAspectFit
        delete.clipsToBounds = true
        addSubview(delete)
        delete.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 40, height: 0, enableInsets: false)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        delete.isUserInteractionEnabled = true
        delete.addGestureRecognizer(singleTap)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

}
