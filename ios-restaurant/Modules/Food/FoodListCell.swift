//
//  FoodListCell.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import SnapKit

class FoodListCell: UITableViewCell {
    var foodImgv: UIImageView! = {
        
        let imgv = UIImageView();
        imgv.clipsToBounds = true;
        imgv.layer.cornerRadius = 5.0;
        
        return imgv;
    }();
    
    var title: UILabel! = {
        let lbl = UILabel();
        
        return lbl;
    }();
    
    var subTitle: UILabel! = {
        let lbl = UILabel();
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light);
        lbl.textColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:1.0);

        return lbl;
    }();
    
    var priceTag: UILabel! = {
        
        let lbl = UILabel();
        lbl.clipsToBounds = true;
        lbl.layer.cornerRadius = 5.0;
        lbl.backgroundColor = UIColor(red:0.82, green:0.80, blue:0.80, alpha:1.0);
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light);
        
        
        return lbl;
    }();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        initCell();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        foodImgv.image = nil;
        title.text = "";
        subTitle.text = "";
        
    }
    
    func initCell() -> Void {
        
        self.backgroundColor = UIColor.clear;
        self.addSubview(foodImgv);
        self.addSubview(title);
        self.addSubview(subTitle);
        self.addSubview(priceTag);
        
        foodImgv.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(150);
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(foodImgv.snp.bottom).offset(15);
            make.left.equalTo(foodImgv);
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10);
            make.left.equalTo(title);
        }
        
        priceTag.snp.makeConstraints { (make) in
            make.top.equalTo(subTitle.snp.bottom).offset(10);
            make.left.equalTo(subTitle);
            make.bottom.equalTo(0).offset(-10);
        }
        
    }

}


class  FoodDetailCell: UITableViewCell {
    var foodImgv: UIImageView! = {
        let imgv = UIImageView();
        imgv.clipsToBounds = true;
        imgv.layer.cornerRadius = 5.0;
        
        return imgv;
    }();
    
    var title: UILabel! = {
        let lbl = UILabel();
        
        return lbl;
    }();
    
    var subTitle: UILabel! = {
        let lbl = UILabel();
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light);
        lbl.textColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:1.0);
        
        return lbl;
    }();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        initCell();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        foodImgv.image = nil;
        title.text = "";
        subTitle.text = "";
        
    }
    
    func initCell() -> Void {
        self.addSubview(foodImgv);
        self.addSubview(title);
        self.addSubview(subTitle);
        
        foodImgv.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10);
            make.size.equalTo(100);
            make.top.equalTo(0).offset(20).priorityMedium();
            make.bottom.equalTo(0).offset(-20).priorityMedium();
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(foodImgv.snp.right).offset(10)
            make.top.equalTo(foodImgv).offset(10);
            make.right.equalTo(0);
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10);
            make.left.equalTo(title);
        }
        
    }
}


