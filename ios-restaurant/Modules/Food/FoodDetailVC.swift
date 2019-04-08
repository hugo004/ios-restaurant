//
//  FoodDetailVC.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class FoodDetailHeaderView: UIView {
    var imageView: UIImageView! = {
        let imgv = UIImageView();
        
        return imgv;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        initView();
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
        initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() -> Void {
        self.addSubview(imageView);
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }
    }
}

class FoodDetailModel {
    var category: FoodCategory!;
    var foodList: [Food] = [];
    
    init(category: FoodCategory) {
        self.category = category;
        
        foodList = StorageHelper.retreiveFoods(type: FoodType(rawValue: category.category)!);
    }
}

class FoodDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!;
    var model: FoodDetailModel!;
    
    init(category: FoodCategory) {
        super.init(nibName: nil, bundle: nil);
        model = FoodDetailModel(category: category);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
        
        initTableView();
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        self.setTransparentNavBar(active: true);
//        self.setNavBarTintColor(color: .white);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        self.setTransparentNavBar(active: false);
//        self.setNavBarTintColor(color: .black);

    }
    
    func initTableView() -> Void {
        let height: CGFloat =  (self.navigationController?.navigationBar.bounds.size.height)! + 45;

        tableView = UITableView(frame: self.view.bounds, style: .grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0);
        tableView.separatorStyle = .singleLine;
        tableView.backgroundColor = UIColor.white;
        
        
        //set header view
        let header = FoodDetailHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200));
        header.imageView.image = UIImage(data: model.category.image);
        tableView.tableHeaderView = header;
        
        self.view.addSubview(tableView);
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide);
            make.top.equalTo(self.view).offset(-0);
        }

        
//        let limit: CGFloat   = header.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)!) - 50;
//        self.setNavBarTransparentEffect(base: limit, hearder: header);
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.category.category;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.foodList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell: FoodDetailCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodDetailCell;
        if cell == nil {
            cell = FoodDetailCell(style: .default, reuseIdentifier: identifier);
            cell?.selectionStyle = .none;
        }
        
        let food: Food = model.foodList[indexPath.row];
        
        cell?.foodImgv.image = UIImage(data: food.image!);
        cell?.title.text = food.name;
        cell?.subTitle.text = "HK$\(food.price)";
        cell?.accessoryType = .disclosureIndicator
        
        return cell!;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food: Food = model.foodList[indexPath.row];
        self.navigationController?.pushViewController(FoodOrderVC(food: food), animated: true);
    }

}
