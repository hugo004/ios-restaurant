//
//  FoodListVC.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class FoodListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!;
    
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

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell: FoodListCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodListCell;
        if cell == nil {
            cell = FoodListCell(style: .default, reuseIdentifier: identifier);
            cell?.selectionStyle = .none;
        }
        
        cell?.foodImgv.backgroundColor = UIColor.blue;
        cell?.title.text = "Food name";
        cell?.subTitle.text = "Category";
        cell?.priceTag.text = "HK$ 10";
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FoodDetailVC(), animated: true);
    }
}
