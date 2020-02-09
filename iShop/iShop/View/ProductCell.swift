//
//  ProductCell.swift
//  iShop
//
//  Created by Jaafar Rammal on 2/9/20.
//  Copyright © 2020 Jaafar Rammal. All rights reserved.
//

import UIKit
class ProductCell : UITableViewCell {
 
    struct Product {
        var productName : String
        var productImage : UIImage
        var productDesc : String
    }
    
    var product : Product? {
        didSet {
            productImage.image = product?.productImage
            productNameLabel.text = product?.productName
            productDescriptionLabel.text = product?.productDesc
        }
    }


    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .right
        return lbl
    }()


    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    var productPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
            label.text = "1"
        label.textColor = .black
        return label
    }()

    private let productImage : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "green"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        addSubview(productPrice)
        addSubview(productImage)

        productNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 100, height: 0, enableInsets: false)
        productImage.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 40, height: 0, enableInsets: false)
        productPrice.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)

        self.selectionStyle = .none
    }
    
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

}
