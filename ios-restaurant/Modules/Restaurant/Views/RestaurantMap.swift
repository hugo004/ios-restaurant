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
        
        imgMap.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.centerY.equalTo(self)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
