//
//  BaseViewController.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIScrollViewDelegate {
    
    var headerView: UIView?;
    var isBarTransparent: Bool = false;
    var base: CGFloat = 10;
    var rect: CGRect = CGRect.zero;
    var barStyle: UIStatusBarStyle = .default;

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.while};
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        self.setTitleColor(color: UIColor.black);
        self.setNavBarColor(color: UIColor.white);
        
        
        if headerView != nil {
            self.setNavBarTintColor(color: UIColor.white);
            self.setTransparentNavBar(active: true);
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        if headerView != nil {
            self.setTransparentNavBar(active: false);
            self.setNavBarTintColor(color: UIColor.black);
        }
    }
    
    
    func setTitleColor(color: UIColor) {
//        self.navigationController?.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
        self.navigationController?.navigationBar.tintColor = color;
    }
    
    func setNavBarColor(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color;
        self.navigationController?.navigationBar.isTranslucent = false;

    }
    
    func setNavBarTintColor(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color;
        self.navigationItem.leftBarButtonItem?.tintColor = color;
        self.navigationItem.rightBarButtonItem?.tintColor = color;
    }
    
    func setTransparentNavBar(active: Bool) {
        isBarTransparent = active;
        
        if isBarTransparent {
            self.transparent();
        }
        else {
            self.reverTransparent();
        }
    }
    
    func transparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default);
        self.navigationController?.navigationBar.shadowImage = UIImage();
        self.navigationController?.navigationBar.isTranslucent = true;
    }
    
    func reverTransparent() {
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    func setNavBarAlpha(alpha: CGFloat) {
        self.navigationController?.navigationBar.alpha = alpha;
    }
    
    
    func setNavBarTransparentEffect(base: CGFloat, hearder: UIView) {
        self.base = base;
        self.headerView = hearder;
        self.rect = headerView!.frame;
        
        barStyle = .lightContent;
        self.setNeedsStatusBarAppearanceUpdate();
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (headerView != nil && base > 0)
        {
            let offsetY: CGFloat = scrollView.contentOffset.y;
            
            //change navigation bar
            
            let alpha: CGFloat       = offsetY / base;
            let  color:UIColor      = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: alpha);
            let changeLimit: CGFloat = 0.75;
            
            
            self.navigationController?.navigationBar.backgroundColor         = color;
            self.navigationController?.navigationBar.tintColor               = UIColor(hue: 1, saturation: alpha, brightness: 1, alpha: 1);
            let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame);
            statusBarView.frame = CGRect(origin: statusBarView.frame.origin, size: CGSize(width: statusBarView.frame.size.width, height: statusBarView.frame.size.height+50));
            statusBarView.backgroundColor = color;
            
            
            if (alpha > changeLimit)
            {
                self.setNavBarTintColor(color: .black);
                barStyle = .default;
            }
            else
            {
                self.setNavBarTintColor(color: .white);
                barStyle = .lightContent;
            }
            
            self.setNeedsStatusBarAppearanceUpdate();

            
            
//            if (offsetY < 0) {
//                //header view image bouce effect
//                let newHeight: CGFloat   = rect.size.height - offsetY; //eqaul + offsetY(positive), -- equal +
//                var newRect: CGRect      = rect;
//                newRect.size.height = newHeight;
//                newRect.origin.y    = offsetY;
//                headerView!.frame   = newRect;
//
//            }
        }
    }
    
    
    func requestPermission(title: String) {
//        UIAlertController *alert = [UIAlertController  alertControllerWithTitle:title
//            message:LocalizedString(@"permission_message") preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *goToSettingAction = [UIAlertAction actionWithTitle:LocalizedString(@"permission_settings") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            }];
//
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LocalizedString(@"permission_cancel") style:UIAlertActionStyleCancel handler:nil];
//
//        [alert addAction:cancelAction];
//        [alert addAction:goToSettingAction];
//        [self presentViewController:alert animated:YES completion:nil];
    }
    
    

}



