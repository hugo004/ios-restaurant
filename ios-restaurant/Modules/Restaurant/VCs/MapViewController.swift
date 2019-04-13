//
//  MapViewController.swift
//  ios-restaurant
//
//  Created by rzc on 11/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    var restaurant:Restaurant?
    var mapview: RestaurantMap!
    var riv: RestaurantInfoView!
    var coverImg: CoverImageView!
    let menuBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20, y: 260, width: 68, height: 68))
        //        btn.font = .systemFont(ofSize: 14, weight: .bold)
        //        btn.setTitle(Helper.Localized(key: "r_map_btn"), for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setImage(UIImage(named: "icon-food-menu"), for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        initView()
        self.view.addSubview(menuBtn)
        menuBtn.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20);
            make.size.equalTo(CGSize(width: 50, height: 50));
        }
        menuBtn.reactive.controlEvents(.touchUpInside).observe { _ in
            let vc = RestaurantMenu()
            self.navigationController?.pushViewController(vc, animated: false)
        }
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
        coverImg = CoverImageView()
        self.navigationItem.title = restaurant?.name
        riv = RestaurantInfoView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        riv.sizeToFit()
        //update info
        if let r = restaurant {
            riv.addressLbl2.text = r.address
            riv.phoneLbl2.text = r.phone.description
            coverImg.coverImgView.image = UIImage(data: r.img!)
            
        }

        
        
        
        
        mapview = RestaurantMap.init(frame: CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: self.view.frame.size.height - riv.bounds.height))
        self.view.addSubview(riv)
        self.view.addSubview(mapview)
    }

}
