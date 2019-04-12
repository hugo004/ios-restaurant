//
//  MapViewController.swift
//  ios-restaurant
//
//  Created by rzc on 11/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    var mapview: RestaurantMap!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        initView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func initView() -> Void {
        mapview = RestaurantMap.init(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 700))
        self.view.addSubview(mapview)
    }

}
