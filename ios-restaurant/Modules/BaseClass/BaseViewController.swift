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
    var originColor: UIColor! = UIColor(red:0.28, green:0.26, blue:0.26, alpha:1.0);

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.barStyle;
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
        self.setNavBarTintColor(color: originColor);

        
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
            
            //get statu bar view, make the color same with status bar view
            UIApplication.shared.StatusBar().backgroundColor = color;
        
            let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame);
            statusBarView.frame = CGRect(origin: statusBarView.frame.origin, size: CGSize(width: statusBarView.frame.size.width, height: statusBarView.frame.size.height));
            statusBarView.backgroundColor = color;
            
            
            if (alpha > changeLimit)
            {
                self.setNavBarTintColor(color: originColor);
                self.barStyle = .default;
            }
            else
            {
                self.setNavBarTintColor(color: .white);
                self.barStyle = .lightContent;
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
    
    
    func requestPermission(title: String?) {
        let alert: UIAlertController = UIAlertController(title: title, message: Helper.Localized(key: "permission_no_permission"), preferredStyle: .alert);
        
        let ok = UIAlertAction(title: Helper.Localized(key: "common_setting"), style: .destructive) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        };
        
        let cancel = UIAlertAction(title: Helper.Localized(key: "common_cancel"), style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil);
        };
        
        alert.addAction(ok);
        alert.addAction(cancel);
        
        self.present(alert, animated: true, completion: nil);
    }
    
    

}



