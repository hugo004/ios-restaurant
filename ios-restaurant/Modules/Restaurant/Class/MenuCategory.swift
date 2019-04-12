//
//  MenuCategory.swift
//  ios-restaurant
//
//  Created by rzc on 9/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation

enum MenuCategory: String, CaseIterable  {
    case Today = "Today"
    case Regular = "Regular"
    case Recommand = "Recommand"
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    static let allValues = [Today, Regular, Recommand, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday]
}
