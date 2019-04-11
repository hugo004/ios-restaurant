//
//  ProfileEditVC.swift
//  ios-restaurant
//
//  Created by Hugo on 7/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit


class ProfileCell: UITableViewCell {
    
    var editField:UITextField! = {
        let field = UITextField();
        field.borderStyle = UITextField.BorderStyle.roundedRect;
        field.textAlignment = NSTextAlignment.right;
        
        return field;
    }();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.detailTextLabel?.font = self.textLabel?.font;
        self.detailTextLabel?.isHidden = true;
        
        self.textLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        })
        
        self.detailTextLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-10);
        })
        
        self.addSubview(editField);
        editField.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10);
            make.width.equalTo(250);
            make.centerY.equalTo(self);
        }
        
    }
    
    func toggleEditMode(isEditing: Bool) {
        self.isUserInteractionEnabled = isEditing;

        if isEditing {
            self.editField.borderStyle = .roundedRect;
        }
        else {
            self.editField.borderStyle = .none;
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProfileEditModel {
    
    struct DataSource {
        var title: String
        var data: String
    }

    var userInfo: UserInfo = StorageHelper.getUserInfo();
    var profileList:[DataSource]!;
    
    init() {
        profileList = [
            DataSource(title: Helper.Localized(key: "profile_dob"), data: Helper.date2String(date: userInfo.dob, format: "yyyy-MM-dd")),
            DataSource(title: "\(Helper.Localized(key: "profile_height")) (cm)", data: String(userInfo.height)),
            DataSource(title: "\(Helper.Localized(key: "profile_weight")) (kg)", data: String(userInfo.weight))
        ];
    }
}

class ProfileEditVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Rows: Int {
        case Dob = 0
        case Height = 1
        case Weight = 2
    }

    var tableView: UITableView!;
    var isEditMode: Bool = false;
    var model: ProfileEditModel = ProfileEditModel();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView();
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Helper.Localized(key: "profile_edit"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(editMode));
        
    }
    
    @objc func editMode() {
        isEditMode = !isEditMode;
        
        if isEditMode {
            self.navigationItem.rightBarButtonItem?.title = Helper.Localized(key: "profile_update");
        } else {
            self.navigationItem.rightBarButtonItem?.title = Helper.Localized(key: "profile_edit");
            
            //update user Info
            var newInfo = model.userInfo;
            newInfo.height = Int(model.profileList[Rows.Height.rawValue].data)!;
            newInfo.weight = Int(model.profileList[Rows.Weight.rawValue].data)!;
            newInfo.dob = Helper.string2Date(dateString: model.profileList[Rows.Dob.rawValue].data);
            
            StorageHelper.updateUserInfo(new: newInfo);
            
        }
        
        tableView.reloadData();
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
        return model.profileList.count;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: tableView.frame);
        
        let image = UIImage(data: model.userInfo.icon ?? Data()) ?? UIImage(named: "icon-profile-avatar");
        let icon = UIImageView(image: image);
        icon.clipsToBounds = true;
        icon.layer.borderWidth = 1;
        icon.layer.cornerRadius = 50 / 2 ;
        icon.layer.borderColor = UIColor.lightGray.cgColor;
        
        let role = UILabel();
        role.text = "\(model.userInfo.name) (\(model.userInfo.role))";
        
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
        
        
        return header;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell: ProfileCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? ProfileCell;
        if cell == nil {
            cell = ProfileCell(style: .subtitle, reuseIdentifier: identifier);
            cell?.selectionStyle = .none;
            cell?.editField.keyboardType = .numberPad;
            //observer text change
            cell?.editField.reactive.controlEvents(.editingDidEnd).observe({ _ in
                self.model.profileList[indexPath.row].data = (cell?.editField.text)!;
            })
        }
        
        
        cell?.textLabel?.text = model.profileList[indexPath.row].title;
        cell?.editField?.text = model.profileList[indexPath.row].data;
        cell?.toggleEditMode(isEditing: isEditMode);
        
        
        if indexPath.row == Rows.Dob.rawValue {
            let picker = UIDatePicker();
            picker.datePickerMode = .date;
            picker.maximumDate = Date();
            
            picker.reactive.controlEvents(.valueChanged).observe { _ in
                cell?.editField.text = Helper.date2String(date: picker.date, format: "yyyy-MM-dd");
            }
            
            cell?.editField.inputView = picker;
        }
        
        return cell!;
    }
    

}
