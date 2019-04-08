//
//  RestaurantInfoView.swift
//  ios-restaurant
//
//  Created by rzc on 5/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class RestaurantInfoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let coverImg: UIImage = {
        let img = UIImage()
        
        return img
    }()
    let coverImgView: UIImageView = {
        let imgView = UIImageView()
        
//        imgView.topAnchor = 0
//        imgView.leftAnchor = 0
//        imgView.rightAnchor = 0
//        imgView.heightAnchor = 200
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    
    let mapBtn: UIButton = {
        let btn = UIButton()
//        btn.font = .systemFont(ofSize: 14, weight: .bold)
        btn.setTitle("View by Google Map", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        
       return btn
    }()
    
    let cat: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 38, weight: .bold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let phoneLbl1: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        return lbl
    }()
    
    let addressLbl1: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        return lbl
    }()
    
    let phoneLbl2: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        return lbl
    }()
    
    let addressLbl2: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        return lbl
    }()

}
