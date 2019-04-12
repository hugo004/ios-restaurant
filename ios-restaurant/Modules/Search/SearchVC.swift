//
//  SearchVC.swift
//  ios-restaurant
//
//  Created by Ng Chi Kin on 9/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var locationImage : UIImageView!
    var locationTxt : UITextField!
    var restaurantTxt : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() -> Void {
        let displayWidth: CGFloat = self.view.frame.width
        
        locationTxt = UITextField(frame: CGRect(x: 5, y: 0, width: displayWidth-10, height: 50))
        locationTxt.layer.borderWidth = 1
        locationTxt.layer.borderColor = UIColor.black.cgColor
        locationTxt.leftViewMode = .always
        locationTxt.placeholder = "Location"
        
        
        locationImage = UIImageView(frame: CGRect(x: 5, y: 5, width: locationTxt.frame.height-10, height: locationTxt.frame.height-10))
        locationImage.image = UIImage(named: "earth-america-7")
        locationTxt.leftView = locationImage
        
        
        self.view.addSubview(locationTxt)
    }


}
