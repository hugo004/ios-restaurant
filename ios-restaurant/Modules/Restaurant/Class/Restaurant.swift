//
//  Restaurant.swift
//  ios-restaurant
//
//  Created by rzc on 9/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit


struct Restaurant: Codable {
    var name: String
    var address: String
    var phone: Int
    var img: Data?
    
    init(name: String, address: String, phone: Int, img: UIImage) {
        self.name = name;
        self.address = address;
        self.phone = phone;
        self.img = img.pngData();
    }
    init(name: String, address: String, phone: Int) {
        self.name = name;
        self.address = address;
        self.phone = phone;
        self.img = nil
    }
    
}
