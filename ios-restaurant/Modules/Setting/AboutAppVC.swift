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
        let img = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 43.5, y: self.view.bounds.height / 2 - 200, width: 87, height: 87))
        img.image = UIImage(named: "map")
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        img.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        img.centerYAnchor.constraint(equalTo:self.view.centerYAnchor).isActive = true
        
        let lbl = UILabel(frame: CGRect(x: 0, y:  self.view.bounds.height / 2 - 150, width: self.view.bounds.width, height: 300));
        lbl.text = Helper.Localized(key: "ec_desc");
        lbl.backgroundColor = UIColor.white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
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
