

import UIKit
import LocalAuthentication

class LoginView: UIView {
    var userNameLabel: UILabel! = {
        let lbl = UILabel();
        lbl.text = Helper.Localized(key: "login_username");
        
        return lbl;
    }();
    
    var passwordLabel: UILabel! = {
        let lbl = UILabel();
        lbl.text = Helper.Localized(key: "login_password");
        
        return lbl;
    }();
    
    var userName: UITextField! = {
        let txf = UITextField();
        txf.borderStyle = UITextField.BorderStyle.roundedRect;
        txf.placeholder = Helper.Localized(key: "login_username");
        
        return txf;
    }();
    
    var password: UITextField! = {
        let txf = UITextField();
        txf.borderStyle = UITextField.BorderStyle.roundedRect;
        txf.placeholder = Helper.Localized(key: "login_password");
        
        return txf;
    }();
    
    var appIcon: UIImageView = {
        let imgv = UIImageView(image: UIImage(named: "logo"));
        
        return imgv;
    }();
    
    var login: UIButton! = {
        let btn = UIButton();
        btn.setTitle(Helper.Localized(key: "login_login"), for: .normal);
        btn.backgroundColor = UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0);
        btn.clipsToBounds = true;
        btn.layer.cornerRadius = 5;
        
        return btn;
    }();
    
    var reset: UIButton! = {
        let btn = UIButton();
        btn.setTitle(Helper.Localized(key: "login_cancel"), for: .normal);
        btn.backgroundColor = UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0);
        btn.clipsToBounds = true;
        btn.layer.cornerRadius = 5;
        
        return btn;
    }();
    
    private var container: UIView = {
        let view = UIView();
        view.layer.borderWidth = 1;
        view.layer.cornerRadius = 5;
        view.layer.borderColor = UIColor.lightGray.cgColor;
        
        return view;
    }();
    
    var backgroundView: UIImageView! = {
        let view = UIImageView();
        
        return view;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
        
        
        self.addSubview(backgroundView);
        self.addSubview(appIcon);
        self.addSubview(container)
        
        container.addSubview(userNameLabel);
        container.addSubview(passwordLabel);
        container.addSubview(userName);
        container.addSubview(password);
        container.addSubview(login);
        container.addSubview(reset);
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }
        
        appIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self);
            make.top.equalTo(0).offset(80);
            make.size.equalTo(200);
        }
        
        container.snp.makeConstraints { (make) in
            make.center.equalTo(self);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0).offset(20);
            make.top.equalTo(0).offset(50);
            make.width.equalTo(100);
        }
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel.snp.right).offset(10);
            make.right.equalTo(0).offset(-20);
            make.top.equalTo(userNameLabel);
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel);
            make.top.equalTo(userNameLabel.snp.bottom).offset(20);
        }
        
        password.snp.makeConstraints { (make) in
            make.left.right.equalTo(userName);
            make.top.equalTo(passwordLabel);
        }
        
        login.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel);
            make.top.equalTo(password.snp.bottom).offset(50);
            make.width.equalTo(login.superview!).multipliedBy(0.4);
            make.height.equalTo(40);
            make.bottom.equalTo(0).offset(-30);
        }
        
        reset.snp.makeConstraints { (make) in
            make.size.top.equalTo(login);
            make.right.equalTo(password);
        }
        
    }
}
    

class LoginVC: UIViewController {
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.white;
        
        
        loginView = LoginView();
        loginView.reset.reactive.controlEvents(.touchUpInside).observe { _ in
            self.dismiss(animated: true, completion: nil);
        }
        
        self.view.addSubview(loginView);
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
    }

}
