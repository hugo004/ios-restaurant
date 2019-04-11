//
//  UIApplication+StatusBar.swift
//  ios-restaurant
//
//  Created by Hugo on 11/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    func StatusBar() -> UIView {
        let view = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as! UIView;
        return view;
    }
    
}
