//
//  FoodOrderVC.swift
//  ios-restaurant
//
//  Created by Hugo on 6/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class OrderButton: UIView {
    let order: UILabel = {
        let lbl = UILabel();
        lbl.text = "1";
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold);
        lbl.textAlignment = NSTextAlignment.center;
        return lbl;
    }();
    
    let minuse: UIButton = {
        let btn = UIButton();
        btn.clipsToBounds = true;
        btn.layer.cornerRadius = 5;
        btn.setBackgroundImage(UIImage(named: "icon-minus"), for: .normal);
        
        return btn;
    }();
    
    let plus: UIButton = {
        let btn = UIButton();
        btn.clipsToBounds = true;
        btn.layer.cornerRadius = 5;
        btn.setBackgroundImage(UIImage(named: "icon-plus"), for: .normal);
        
        return btn;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
        
        self.addSubview(order);
        self.addSubview(minuse);
        self.addSubview(plus);
        
        order.snp.makeConstraints { (make) in
            make.center.equalTo(self);
            make.width.equalTo(50);
        }
        
        minuse.snp.makeConstraints { (make) in
            make.centerY.equalTo(order);
            make.right.equalTo(order.snp.left).offset(-15);
            make.size.equalTo(50);
        }
        
        plus.snp.makeConstraints { (make) in
            make.centerY.equalTo(order);
            make.left.equalTo(order.snp.right).offset(15);
            make.size.equalTo(50);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FoodOrderVC: UIViewController {
    
    var food: UIImageView! = {
        let imgv = UIImageView();
        imgv.layer.borderWidth = 1;
        return imgv;
    }();
    
    var foodTitle: UILabel! = {
        let lbl = UILabel();
        lbl.text = "Food name";
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold);
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping;
        lbl.numberOfLines = 0;
        
        return lbl;
    }();
    
    var remark: UITextView! = {
        let remark = UITextView();
        remark.text = "Remark for the food: e.g more rice";
        remark.font = UIFont.systemFont(ofSize: 17, weight: .light);
        remark.clipsToBounds = true;
        remark.layer.cornerRadius = 5
        remark.layer.borderWidth = 1;
        remark.layer.borderColor = UIColor(red:0.77, green:0.73, blue:0.73, alpha:1.0).cgColor;
        
        return remark;
    }();
    
    var orderButton: OrderButton = {
        let btn = OrderButton();
        
        return btn;
    }();
    
    var status: UILabel = {
        let lbl = UILabel();
        lbl.text = "Status: (On sale / Sale out)";
        
        return lbl;
    }();
    
    var confirmButton: UIButton = {
        let btn = UIButton();
        btn.setTitle("Order", for: .normal);
        btn.clipsToBounds = true;
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = UIColor(red:0.44, green:0.62, blue:0.93, alpha:1.0);
        
        return btn;
    }();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        self.view.addSubview(food);
        self.view.addSubview(foodTitle);
        self.view.addSubview(remark);
        self.view.addSubview(orderButton);
        self.view.addSubview(status);
        self.view.addSubview(confirmButton);
        
        food.snp.makeConstraints { (make) in
            make.top.width.equalTo(self.view);
            make.height.equalTo(300);
        }
        
        foodTitle.snp.makeConstraints { (make) in
            make.top.equalTo(food.snp.bottom).offset(20);
            make.left.equalTo(self.view).offset(20);
        }
        
        status.snp.makeConstraints { (make) in
            make.top.equalTo(foodTitle.snp.bottom).offset(10);
            make.left.equalTo(foodTitle);
        }
        
        remark.snp.makeConstraints { (make) in
            make.top.equalTo(status.snp.bottom).offset(15);
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.height.equalTo(200);
        }
        
        orderButton.snp.makeConstraints { (make) in
            make.top.equalTo(remark.snp.bottom).offset(30);
            make.centerX.equalTo(self.view);
            make.size.equalTo(CGSize(width: 200, height: 100));
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10);
            make.centerX.equalTo(self.view);
            make.size.equalTo(CGSize(width: 200, height: 50));
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

}
