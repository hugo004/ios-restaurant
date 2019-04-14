//
//  SettingVC.swift
//  CheckListReminder
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import ReactiveSwift

struct DataSource {
    var name: String
    var value: String
    
    init(name: String)
    {
        self.name = name;
        self.value = "";
    }
    
    init (name: String, value: String)
    {
        self.name = name;
        self.value = value;
    }
}

enum Rows: Int {
    case Permission = 0
    case AboutApp = 1
}

enum Sections: Int {
    case General = 0
    case Language = 1
    case Logout = 2
}

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
    
    var userInfo: UserInfo!;
    var isLogin = false;
    
    func reloadData()  {
        userInfo = StorageHelper.getUserInfo();
        
        if userInfo.name != "" {
            isLogin = true;
        } else {
            isLogin = false;
        }
    }
    
}


class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var general: [DataSource] = {
        var datas: [DataSource] = []
        datas.append(DataSource(name: Helper.Localized(key: "setting_permission")))
        datas.append(DataSource(name: Helper.Localized(key: "setting_aboutapp")))
        
        return datas;
    }()
    
    var langauges: [Language] = {
        var datas: [Language] = []
        
        datas.append(Language(name: Helper.Localized(key: "language_chinese"), code:"zh-HK"))
        datas.append(Language(name: Helper.Localized(key: "language_english"), code: "en"))
        
        return datas
    }()
    
     private var model: ProfileModel = ProfileModel();
    
    var dispos: Disposable!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView                   = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.rowHeight         = UITableView.automaticDimension
        tableView.separatorStyle    = .singleLine
        
        self.view.addSubview(tableView);
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;
        
        
        model.reloadData();

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        model.reloadData();
        tableView.reloadData();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        dispos.dispose();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.General.rawValue:
            return general.count;
        case Sections.Language.rawValue:
            return langauges.count;
        case Sections.Logout.rawValue:
            if model.isLogin {
                return 1;
            }
            return 0;
        default:
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.Language.rawValue:
            return Helper.Localized(key: "setting_language");
        default:
            return "";
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = UIView(frame: tableView.frame);
            header.backgroundColor = .white;
            
            
            
            let icon = UIImageView(image: UIImage(named: "icon-profile-avatar"));
            icon.clipsToBounds = true;
            icon.layer.borderWidth = 1;
            icon.layer.cornerRadius = 50 / 2 ;
            icon.layer.borderColor = UIColor.lightGray.cgColor;
            
            let role = UILabel();
            
            if model.userInfo.icon != nil {
                icon.image = UIImage(data: model.userInfo.icon!);
            }
            
            if model.userInfo.name != "" {
                role.text = "\(model.userInfo.name) (\(model.userInfo.role))";
            } else {
                role.text = "(\(Helper.Localized(key: "role_guest")))";
            }
            
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
            
            
            
            dispos = button.reactive.controlEvents(.touchUpInside).observe { _ in
                if self.model.isLogin {
                    self.navigationController?.pushViewController(ProfileEditVC(), animated: true);
                } else {
                    let login = LoginVC();
                    self.navigationController?.pushViewController(login, animated: true);
                }
                
                self.dispos.dispose();
            }
            
            return header;
        }
        
        return nil;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier              = "cell"
        var cell                    = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil
        {
            cell                    = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.selectionStyle    = .none
            cell?.accessoryType = .disclosureIndicator
        }
        
        if indexPath.section == Sections.General.rawValue
        {
            cell?.textLabel?.text       = general[indexPath.row].name
        }
        else if indexPath.section == Sections.Language.rawValue
        {
            cell?.textLabel?.text       = langauges[indexPath.row].name
            if Helper.currentLanguage() == langauges[indexPath.row].code
            {
                cell?.accessoryType = .checkmark;
            }
            else
            {
                cell?.accessoryType = .none;
            }
        }
        else if indexPath.section == Sections.Logout.rawValue {
            cell?.textLabel?.text = Helper.Localized(key: "setting_logout");
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == Sections.General.rawValue
        {
            if indexPath.row == Rows.Permission.rawValue
            {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            else if indexPath.row == Rows.AboutApp.rawValue
            {
                self.navigationController?.pushViewController(AboutAppVC(), animated: true)
            }
        }
        else if indexPath.section == Sections.Language.rawValue
        {
            Helper.changeLanguage(code: langauges[indexPath.row].code);
            self.navigationController?.setViewControllers([HomeVC()], animated: true);
        }
        else if indexPath.section == Sections.Logout.rawValue {
            dispos.dispose();
            Helper.logout();
            model.reloadData();
            tableView.reloadData();
        }
    }
    
}
