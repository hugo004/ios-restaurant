//
//  HomeVC.swift
//  ec-calendar
//
//  Created by Hugo on 22/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class HomeVC: UITabBarController {
    
    let Hugo: FoodListVC = {
        let vc = FoodListVC()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "Hugo"), image: UIImage(named:"icon-calendar-blue"), tag: 0)
        
        return vc
    }()
    
    let Sam: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "Sam") , image: UIImage(named:"icon-settings-white"), tag: 1)
        
        return vc
    }()
    
    var Terry: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "Terry"), image: UIImage(named:"icon-document"), tag: 1)
        
        return vc
    }()
    
    
    var Renee: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "Renee"), image: UIImage(named:"icon-document"), tag: 1)
        
        return vc
    }()
    
    let profile: ProfileVC = {
        let vc = ProfileVC()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "home_profile") , image: UIImage(named:"icon-profile"), tag: 1)
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("current lan:", Helper.currentLanguage());
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = [];
        self.view.backgroundColor = .white;
        //        self.extendedLayoutIncludesOpaqueBars = true;
        
        self.viewControllers = [Sam, Renee, Hugo, Terry, profile];
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    

}
