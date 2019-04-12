//
//  RestaurantMap.swift
//  ios-restaurant
//
//  Created by rzc on 7/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import SnapKit

class RestaurantMap: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let imgMap: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "map")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imgMap)
        imgMap.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: frame.size.height, enableInsets: false)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
