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
    var food: FoodInfo? {
        didSet {
            priceLabel.text = food?.price
            foodName.text = food?.name
            foodIndicator.text = food?.indicator
            
        }
    }
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 13, weight: .bold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    let foodName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12, weight: .bold)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let foodIndicator: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(foodIndicator)
        self.contentView.addSubview(foodName)
        self.contentView.addSubview(priceLabel)
        

        
        foodIndicator.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: 70, height: 0, enableInsets: false)
        foodName.anchor(top: topAnchor, left: foodIndicator.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: frame.size.height, enableInsets: false)
        priceLabel.anchor(top: topAnchor, left: foodName.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 20, width: frame.size.width / 2 - foodName.frame.width, height: 0, enableInsets: false)
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
