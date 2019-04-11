//
//  ProfileVC.swift
//  ios-restaurant
//
//  Created by Hugo on 7/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import ReactiveCocoa


private class ProfileModel {

    struct DataSource {
        var icon: UIImage?
        var name: String
        
        
        init(icon: UIImage?, name: String) {
            self.icon = icon;
            self.name = name;
        }
        
    }
    
     var dataSource: [DataSource] = [
        DataSource(icon: UIImage(named: "icon-setting"), name: Helper.Localized(key: "home_setting"))
    ];

    
    
}

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!;
    private var model: ProfileModel = ProfileModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView();
        // Do any additional setup after loading the view.
    }
    

    func initTableView() -> Void {
        
        tableView = UITableView(frame: self.view.bounds, style: .grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0);
        tableView.separatorStyle = .singleLine;
        tableView.backgroundColor = UIColor.white;
        
        self.view.addSubview(tableView);
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: tableView.frame);
        
        let userInfo = StorageHelper.getUserInfo();
        let image = UIImage(data: userInfo.icon ?? Data()) ?? UIImage(named: "icon-profile-avatar");
        let icon = UIImageView(image: image);
        icon.clipsToBounds = true;
        icon.layer.borderWidth = 1;
        icon.layer.cornerRadius = 50 / 2 ;
        icon.layer.borderColor = UIColor.lightGray.cgColor;
        
        let role = UILabel();
        role.text = "\(userInfo.name) (\(userInfo.role))";
        
        header.addSubview(icon);
        header.addSubview(role);
        
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(header).offset(15);
            make.left.equalTo(header).offset(20);
            make.bottom.equalTo(header).offset(-15);
            make.size.equalTo(50);
        }
        
        role.snp.makeConstraints { (make) in
            make.centerY.equalTo(header);
            make.left.equalTo(icon.snp.right).offset(20);
        }
        
        let button = UIButton(frame: header.frame);
        header.addSubview(button);
        
        button.reactive.controlEvents(.touchUpInside).observe { _ in
            self.navigationController?.pushViewController(ProfileEditVC(), animated: true);
        }
        
        return header;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier);
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier);
            cell?.selectionStyle = .none;
        }
        
        cell?.imageView?.image = model.dataSource[indexPath.row].icon;
        cell?.textLabel?.text = model.dataSource[indexPath.row].name;
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(SettingVC(), animated: true);
    }

}
