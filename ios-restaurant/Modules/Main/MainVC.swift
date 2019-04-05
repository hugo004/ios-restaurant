//
//  MainVC.swift
//  ios-restaurant
//
//  Created by Ng Chi Kin on 3/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var tv : UITableView!
    var nearByCv : UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()

        // Do any additional setup after loading the view.
    }
    
    func initView() -> Void {
        self.view.backgroundColor = UIColor.white
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tv = UITableView(frame: CGRect(x: 0, y: 0 , width: displayWidth, height: displayHeight))
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
