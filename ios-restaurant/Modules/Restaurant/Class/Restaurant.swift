//
//  Restaurant.swift
//  ios-restaurant
//
//  Created by rzc on 9/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct Restaurant: Codable {
    var name: String
    var address: String
    var lat: Float
    var long: Float
    var phone: Int
    var img: Data?
    
    init(name: String, address: String,lat : Float,long : Float, phone: Int, img: UIImage) {
        self.name = name;
        self.address = address;
        self.phone = phone;
        self.img = img.pngData();
        self.lat = lat
        self.long = long
    }
    
    init(name: String, address: String,lat : Float,long : Float, phone: Int) {
        self.name = name;
        self.address = address;
        self.phone = phone;
        self.img = nil
        self.lat = lat
        self.long = long
    }
    
}
