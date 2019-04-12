

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {
    
    let imgPicture = UIImageView.init()
    let scrollView = UIScrollView.init()
    let lblLoginID = UILabel.init()
    let lblPassword = UILabel.init()
    let txtLoginID = UITextField.init()
    let txtPassword = UITextField.init()
    
    let btnSubmit = UIButton(type: UIButton.ButtonType.system) as UIButton
    let btnClear = UIButton(type: UIButton.ButtonType.system) as UIButton
    var login = "login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       imgPicture.image = UIImage(named:"logo")!
        imgPicture.backgroundColor = UIColor.lightGray
        imgPicture.frame = CGRect(x: (UIScreen.main.bounds.width/2)-75, y: 100, width: 150, height: 150)
        
        UserDefaults.standard.set("admin", forKey: "admin")
        
        lblLoginID.frame = CGRect(x: 9, y: 350, width: 70, height: 21)
        lblLoginID.text = "Login ID:"
     //   lblLoginID.text = Helper.Localized(key: "");
        
        txtLoginID.frame = CGRect(x:  (UIScreen.main.bounds.width/2)-84, y: 345, width: 250, height: 30)
        txtLoginID.layer.borderColor = UIColor.black.cgColor
        txtLoginID.layer.borderWidth = 1
       
        
        
        lblPassword.frame = CGRect(x: 9, y: 450, width: 100, height: 21)
        lblPassword.text = "Password:"
         //   lblPassword.text = Helper.Localized(key: "");
        
        txtPassword.frame = CGRect(x:  (UIScreen.main.bounds.width/2)-84, y: 445, width: 250, height: 30)
        txtPassword.layer.borderColor = UIColor.black.cgColor
        txtPassword.layer.borderWidth = 1
      
        
        
        btnSubmit.frame = CGRect(x: ((UIScreen.main.bounds.width/2)/2)-75, y: 600, width: 150, height: 75)
        btnSubmit.backgroundColor = UIColor.lightGray
        btnSubmit.setTitle("Login", for: UIControl.State.normal)
       // btnSubmit.setTitle(Helper.Localized(key: ""), for: UIControl.State.normal)
        btnSubmit.titleLabel?.font =  UIFont(name: "System", size: 30)
        btnSubmit.tintColor = UIColor.black
        btnSubmit.addTarget(self, action: #selector(LoginVC.Submit(_:)), for: .touchUpInside)
        
        
        btnClear.frame = CGRect(x: ((UIScreen.main.bounds.width/2)+((UIScreen.main.bounds.width/2)/2))-75,y: 600, width: 150, height: 75)
        btnClear.backgroundColor = UIColor.lightGray
          btnClear.setTitle("Clear", for: UIControl.State.normal)
           btnClear.titleLabel?.font =  UIFont(name: "System", size: 30)
        // btnSubmit.setTitle(Helper.Localized(key: ""), for: UIControl.State.normal)
        btnClear.tintColor = UIColor.black
        btnClear.addTarget(self, action: #selector(LoginVC.Clear(_:)), for: .touchUpInside)
        
        
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        scrollView.addSubview(imgPicture)
        scrollView.addSubview(lblLoginID)
        scrollView.addSubview(lblPassword)
        scrollView.addSubview(txtLoginID)
        scrollView.addSubview(txtPassword)
        
        scrollView.addSubview(btnSubmit)
        scrollView.addSubview(btnClear)
        
        self.view.addSubview(scrollView)
        
       
        if let lan =  UserDefaults.standard.string(forKey: "status") {
          touchID()
        }
    }

    
    
    @objc func Submit(_ sender:UIButton!)
    {   let loginID = txtLoginID.text as! String
        
        if let lan = UserDefaults.standard.string(forKey: loginID){
            let Login = UserDefaults.standard.string(forKey: txtLoginID.text!)
            let Password = txtPassword.text
            if Login == Password{
                print("success")
                UserDefaults.standard.set("login", forKey: "status")
                self.loginToDetail()
            }

        }
      
        
        
    }
    
    @objc func Clear(_ sender:UIButton!)
    {
        txtLoginID.text = ""
        txtPassword.text = ""
        
        
    }

    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
         
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
    
    func touchID (){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
           
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please use Touch ID", reply: {success, error in
                
                if success {
                    
                    
                    self.loginToDetail()
                    
                    
                }else {
                    if let error = error as? NSError {
                      
                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                        print(message)
                    }
                }
                
            })
        }
}
    
    
    func loginToDetail (){
        
        
    }

}
