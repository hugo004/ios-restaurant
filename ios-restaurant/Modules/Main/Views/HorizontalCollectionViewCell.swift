//
//  NearByCollectionViewCell.swift
//  ios-restaurant
//
//  Created by Ng Chi Kin on 7/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.yellow
        imageView.frame = CGRect(x: 20, y: 10, width: 210, height: 130)
        return imageView
    }()
    
    let lblName : UILabel = {
        let lblName = UILabel()
        lblName.font = .systemFont(ofSize: 20)
        lblName.frame = CGRect(x: 20, y: 150, width: 210, height: 20)
        return lblName
    }()
    
    let lblDistance : UILabel = {
        let lblDistance = UILabel()
        lblDistance.font = .systemFont(ofSize: 15)
        lblDistance.frame = CGRect(x: 20, y: 180, width: 210, height: 15)
        return lblDistance
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(lblName)
        self.contentView.addSubview(lblDistance)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
