//
//  MainTableViewCell.swift
//  ios-restaurant
//
//  Created by Ng Chi Kin on 7/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(lblTitle)
        
        lblTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
