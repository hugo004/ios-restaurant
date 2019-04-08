//
//  MenuItem.swift
//  ios-restaurant
//
//  Created by rzc on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class MenuItem: UITableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 13, weight: .bold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let foodName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12, weight: .bold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let foodIndicator: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(foodIndicator)
        self.contentView.addSubview(foodName)
        self.contentView.addSubview(priceLabel)
        
//        txtInput.snp.makeConstraints { (make) in
//            make.centerY.equalTo(self)
//            make.left.equalTo(self.contentView).offset(20)
//            make.size.equalTo(CGSize(width: self.contentView.frame.size.width, height: 60))
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
