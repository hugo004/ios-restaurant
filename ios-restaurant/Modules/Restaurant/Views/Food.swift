//
//  Food.swift
//  ios-restaurant
//
//  Created by rzc on 12/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//
import UIKit
import Foundation

struct FoodInfo: Codable {
    var indicator: String
    var name: String
    var price: String
    var available: Bool
    var type: Int
    
    init(indicator: String, name: String, price: String, available: Bool, type: Int) {
        self.indicator = indicator;
        self.name = name;
        self.price = "HKD $" + price;
        self.available = available;
        self.type = type;
    }
    init(indicator: String, name: String, available: Bool, type: Int) {
        self.indicator = indicator;
        self.name = name;
        self.price = "HKD $0.0";
        self.available = available;
        self.type = type
    }
    
}
