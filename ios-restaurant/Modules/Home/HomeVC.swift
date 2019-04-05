//
//  HomeVC.swift
//  ec-calendar
//
//  Created by Hugo on 22/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class HomeVC: UITabBarController {
    
    let Hugo: UIViewController = {
        //let vc = UIViewController()
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "Hugo"), image: UIImage(named:"icon-calendar-blue"), tag: 0)
        
        return vc
    }()
    
    let Sam: UIViewController = {
        let vc = MainVC()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("current lan:", Helper.currentLanguage());
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = [];
        //        self.extendedLayoutIncludesOpaqueBars = true;
        
        self.viewControllers = [Sam, Renee, Hugo, Terry];
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white;
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
    }
}
