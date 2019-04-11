//
//  UITextField+UIBarButton.swift
//  ios-restaurant
//
//  Created by Hugo on 11/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func showToolBar()  {
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50));
        numberToolbar.barStyle = .default;
        
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.resignFirstResponder))
        ];
        numberToolbar.sizeToFit()
        self.inputAccessoryView = numberToolbar
    }
    
}
