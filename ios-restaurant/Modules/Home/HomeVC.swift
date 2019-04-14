//
//  HomeVC.swift
//  ec-calendar
//
//  Created by Hugo on 22/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class HomeVC: UITabBarController {
    
    let home: UIViewController = {
        let vc = MainVC()
        vc.tabBarItem = UITabBarItem(title: nil , image: UIImage(named:"icon-home"), tag: 1)
        vc.title = Helper.Localized(key: "home_home");
        return vc
    }()
    
    
    let setting: SettingVC = {
        let vc = SettingVC()
        vc.tabBarItem = UITabBarItem(title: nil , image: UIImage(named:"icon-setting"), tag: 1);
        vc.title = Helper.Localized(key: "home_setting");

        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        StorageHelper.clearAllStorage();
        if StorageHelper.getFoodCategetory().count < 1 {
            StorageHelper.intiFoodData();
        }
        
        if StorageHelper.getRestaurant().count < 1 {
            StorageHelper.initRestaurantData()
        }

        
        print("current lan:", Helper.currentLanguage());
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = [];
        self.view.backgroundColor = .white;
        //        self.extendedLayoutIncludesOpaqueBars = true;
        
        self.viewControllers = [home, setting];
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    

}
