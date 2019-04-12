//
//  AboutAppVC.swift
//  CheckListReminder
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class AboutAppVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        
        let img = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 45.3, y: self.view.bounds.height / 2 - 200, width: 87, height: 87))
        img.image = UIImage(named: "Icon-87")
//        img.backgroundColor = UIColor.yellow
        let lbl = UILabel(frame: CGRect(x: 0, y:  self.view.bounds.height / 2 - 80, width: self.view.bounds.width, height: 60));
        lbl.text = Helper.Localized(key: "ec_desc");
        lbl.backgroundColor = UIColor.white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        
        self.view.addSubview(img)
        self.view.addSubview(lbl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = Helper.Localized(key: "setting_aboutapp");
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
