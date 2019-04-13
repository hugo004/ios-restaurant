//
//  FoodListVC.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailView: UIView {
    var imageView: UIImageView! = {
        let imgv = UIImageView();
        
        return imgv;
    }();
    
    var title: UILabel! = {
        let lbl = UILabel();
        lbl.font = UIFont.boldSystemFont(ofSize: 20);
        lbl.text = "---";
        return lbl;
    }();
    
    var contact: UILabel! = {
        let lbl = UILabel();
        lbl.text = "---";
        return lbl;
    }();
    
    var address: UILabel! = {
        let lbl = UILabel();
        lbl.numberOfLines = 0;
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping;
        lbl.text = "---";
        return lbl;
    }();
    
    var category: UIButton! = {
        let btn = UIButton();
        btn.setTitle(Helper.Localized(key: "restaurant_category"), for: .normal);
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = UIColor.lightGray.cgColor;
        btn.setTitleColor(UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0), for: .normal);
        
        return btn;
    }();
    
    var recommand: UIButton! = {
        let btn = UIButton();
        btn.setTitle(Helper.Localized(key: "restaurant_recommand"), for: .normal);
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0).cgColor;
        btn.layer.borderColor = UIColor.lightGray.cgColor;
        btn.setTitleColor(.black, for: .normal);

        
        return btn;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        initView();
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() -> Void {
        
        self.addSubview(imageView);
        self.addSubview(title);
        self.addSubview(contact);
        self.addSubview(address);
        self.addSubview(category);
        self.addSubview(recommand);
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(self);
            make.height.equalTo(300);
            make.top.centerX.equalTo(self)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(20);
        }
        
        contact.snp.makeConstraints { (make) in
            make.left.right.equalTo(title);
            make.top.equalTo(title.snp.bottom).offset(10);
        }
        
        address.snp.makeConstraints { (make) in
            make.left.right.equalTo(title);
            make.top.equalTo(contact.snp.bottom).offset(10);
        }
        
        category.snp.makeConstraints { (make) in
            make.top.equalTo(address.snp.bottom).offset(20);
            make.height.equalTo(40);
            make.width.equalTo(self).multipliedBy(0.5);
            make.left.equalTo(self);
        }
        
        recommand.snp.makeConstraints { (make) in
            make.right.equalTo(self);
            make.top.size.equalTo(category);
        }
    }
}



class FoodListModel {
    var foodList: [FoodCategory] = StorageHelper.getFoodCategetory();
    var recommandList: [Food] = StorageHelper.retreiveFoods(type: .Recommand);
    var restaurant: Restaurant!;
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant;
    }
}

class FoodListVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var tableView: UITableView!;
    var model: FoodListModel!;
    var header: RestaurantDetailView!
    var locationManager = CLLocationManager();
    var userLocation: CLLocation!;
    var isRecommand = false;

    
    let mapBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20, y: 260, width: 50, height: 50))
        btn.setImage(UIImage(named: "map-icon"), for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        
        return btn
    }()
    
    init(restaurant: Restaurant) {
        super.init(nibName: nil, bundle: nil);
        model = FoodListModel(restaurant: restaurant);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization();
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation();
        
        //header view
        header = RestaurantDetailView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 480));
        header.imageView.image = UIImage(data: model.restaurant.img!);
        header.title.text = model.restaurant.name;
        header.contact.text = "\(Helper.Localized(key: "restaurant_phone")): \(String(model.restaurant.phone))";
        header.address.text = "\(Helper.Localized(key: "restaurant_address")): \(model.restaurant.address)";
        
        header.category.reactive.controlEvents(.touchUpInside).observe { _ in
            self.isRecommand = false;
            self.tableView.reloadData();
            
            self.header.category.setTitleColor(UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0), for: .normal);
            self.header.recommand.setTitleColor(.black, for: .normal);
        }
        
        header.recommand.reactive.controlEvents(.touchUpInside).observe { _ in
            self.isRecommand = true;
            self.tableView.reloadData();
            
            self.header.recommand.setTitleColor(UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0), for: .normal);
            self.header.category.setTitleColor(.black, for: .normal);

        }
        
        initTableView();
        // Do any additional setup after loading the view.
        self.view.addSubview(mapBtn);
        mapBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50);
            make.right.equalTo(self.view).offset(-20);
            make.size.equalTo(50);
        }
        
        mapBtn.reactive.controlEvents(.touchUpInside).observe { _ in
            self.navigationController?.pushViewController(MapViewController(restaurant: self.model.restaurant, userLocation: self.userLocation), animated: true);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first;
    }
    
    func initTableView() -> Void {

        
        tableView = UITableView(frame: self.view.bounds, style: .plain);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0);
        tableView.separatorStyle = .none;
        tableView.bounces = false;
        
        tableView.tableHeaderView = header;
        
        self.view.addSubview(tableView);
        
        let height: CGFloat =  (self.navigationController?.navigationBar.bounds.size.height)! + 45;
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide);
            make.top.equalTo(self.view).offset(-height);
        }
        
        let limit: CGFloat   = header.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)!) - 50;
        self.setNavBarTransparentEffect(base: limit, hearder: header);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isRecommand {
            return model.recommandList.count;
        }
        return model.foodList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        if isRecommand {
            var cell: FoodDetailCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodDetailCell;
            if cell == nil {
                cell = FoodDetailCell(style: .default, reuseIdentifier: identifier);
                cell?.selectionStyle = .none;
            }
            
            let food: Food = model.recommandList[indexPath.row];
            
            cell?.foodImgv.image = UIImage(data: food.image!);
            cell?.title.text = food.name;
            cell?.subTitle.text = "HK$\(food.price)";
            cell?.accessoryType = .disclosureIndicator
            
            return cell!;
        } else {
            var cell: FoodListCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodListCell;
            if cell == nil {
                cell = FoodListCell(style: .default, reuseIdentifier: identifier);
                cell?.selectionStyle = .none;
                cell?.foodImgv.contentMode = .scaleAspectFill;
            }
            let category = model.foodList[indexPath.row];
            
            cell?.foodImgv.image = UIImage(data: category.image);
            cell?.title.text = category.category;
            
            return cell!;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isRecommand {
            let food: Food = model.recommandList[indexPath.row];
            self.navigationController?.pushViewController(FoodOrderVC(food: food), animated: true);
        } else {
            let category = model.foodList[indexPath.row];
            self.navigationController?.pushViewController(FoodDetailVC(category: category), animated: true);
        }
    }

}
