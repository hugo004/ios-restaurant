//
//  FoodListVC.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class FoodListModel {
    var foodList: [FoodCategory] = StorageHelper.getFoodCategetory();
}

class FoodListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!;
    var model: FoodListModel = FoodListModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView();
        // Do any additional setup after loading the view.
    }
    
    func initTableView() -> Void {
        tableView = UITableView(frame: self.view.bounds, style: .plain);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0);
        tableView.separatorStyle = .none;
        
        self.view.addSubview(tableView);
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide);
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.foodList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell: FoodListCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodListCell;
        if cell == nil {
            cell = FoodListCell(style: .default, reuseIdentifier: identifier);
            cell?.selectionStyle = .none;
        }
        let category = model.foodList[indexPath.row];
        
        cell?.foodImgv.image = UIImage(data: category.image);
        cell?.title.text = category.category;
        cell?.subTitle.text = category.category;
        cell?.priceTag.text = "HK$ 10 ~ 300";
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = model.foodList[indexPath.row];
        self.navigationController?.pushViewController(FoodDetailVC(category: category), animated: true);
    }
}
