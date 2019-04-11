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

class EditableLabel: UITextField {
    var isEditable: Bool {
        get {
            return isEnabled;
        }
        set (newVal) {
            isEnabled = newVal;
            
            if isEnabled {
                borderStyle = UITextField.BorderStyle.roundedRect;
            }else {
                borderStyle = UITextField.BorderStyle.none;
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class FoodOrderView: UIView {
    var food: UIImageView! = {
        let imgv = UIImageView();
        imgv.isUserInteractionEnabled = true;
        return imgv;
    }();
    
    var foodImageButton: UIButton! = {
        let btn = UIButton(type: .custom);
        btn.setTitle(Helper.Localized(key: "food_no_image"), for: .normal);
        
        return btn;
    }();
    
    var foodTitle: EditableLabel! = {
        let lbl = EditableLabel();
        lbl.text = "Food name";
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold);

        
        return lbl;
    }();
    
    var price: EditableLabel! = {
        let lbl = EditableLabel();
        lbl.text = "Price";
        lbl.keyboardType = UIKeyboardType.decimalPad;
        
        return lbl;
    }();
    
    var priceLabel: UILabel! = {
        let lbl = UILabel();
        lbl.text = "Price";
        
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
        btn.isHidden = true;
        
        return btn;
    }();
    
    var status: EditableLabel = {
        let lbl = EditableLabel();
        lbl.text = "Status: (On sale / Sale out)";
        
        return lbl;
    }();
    
    var statusLable: UILabel = {
        let lbl = UILabel();
        lbl.text = "Status: ";
        
        return lbl;
    }();
    
    var confirmButton: UIButton = {
        let btn = UIButton();
        btn.setTitle(Helper.Localized(key: "food_update"), for: .normal);
        btn.clipsToBounds = true;
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = UIColor(red:0.44, green:0.62, blue:0.93, alpha:1.0);
        btn.isHidden = true;
        
        return btn;
    }();
    
    var statusPickerView: UIPickerView = {
        let picker  = UIPickerView();
        return picker;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
        initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.addSubview(food);
        self.addSubview(foodTitle);
        self.addSubview(remark);
        self.addSubview(orderButton);
        self.addSubview(status);
        self.addSubview(confirmButton);
        self.addSubview(price);
        self.addSubview(foodImageButton);
        self.addSubview(statusLable);
        self.addSubview(priceLabel);
        
        food.snp.makeConstraints { (make) in
            make.top.width.equalTo(self);
            make.height.equalTo(300);
        }
        
        foodImageButton.snp.makeConstraints { (make) in
            make.edges.equalTo(food);
        }
        
        foodTitle.snp.makeConstraints { (make) in
            make.top.equalTo(food.snp.bottom).offset(20);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(foodTitle);
            make.centerY.equalTo(price);
        }
        
        price.snp.makeConstraints { (make) in
            make.top.equalTo(foodTitle.snp.bottom).offset(10);
            make.right.equalTo(foodTitle);
            make.left.equalTo(priceLabel.snp.right).offset(1);
        }
        
        statusLable.snp.makeConstraints { (make) in
            make.left.equalTo(priceLabel);
            make.centerY.equalTo(status);
        }
        
        status.snp.makeConstraints { (make) in
            make.left.equalTo(statusLable.snp.right).offset(1);
            make.right.equalTo(foodTitle);
            make.top.equalTo(price.snp.bottom).offset(10);
        }
        
        remark.snp.makeConstraints { (make) in
            make.top.equalTo(status.snp.bottom).offset(15);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(200);
        }
        
        orderButton.snp.makeConstraints { (make) in
            make.top.equalTo(remark.snp.bottom);
            make.centerX.equalTo(self);
            make.size.equalTo(CGSize(width: 200, height: 100));
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10);
            make.centerX.equalTo(self);
            make.size.equalTo(CGSize(width: 200, height: 50));
        }
        
        
        //override input view
        status.inputView = statusPickerView;
    }
    
    func editMode(isEdit: Bool) {
        foodTitle.isEditable = isEdit;
        price.isEditable = isEdit;
        status.isEditable = isEdit;
        
        foodImageButton.isEnabled = isEdit;
        confirmButton.isHidden = !isEdit;
    }
}

class FoodOrderModel {
    
    struct Status {
        var name: String!
        var value: Int!
        
        init(name: String, value: FoodStatus) {
            self.name = name;
            self.value = value.rawValue;
        }
    }
    
    var food: Food!;
    var status: [Status]! = [
        Status(name: Helper.Localized(key: "food_onSale"), value: .OnSale),
        Status(name: Helper.Localized(key: "food_soldOut"), value: .SoldOut)
    ];
    
    init(food: Food) {
        self.food = food;
    }
    
}

class FoodOrderVC: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var orderView: FoodOrderView!;
    var model: FoodOrderModel!;
    var newFoodStatus: FoodStatus!;
    
    init(food: Food) {
        super.init(nibName: nil, bundle: nil);
        model = FoodOrderModel(food: food);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        orderView = FoodOrderView();
        orderView.food.image = UIImage(data:model.food.image!);
        orderView.foodTitle.text = model.food.name;
        
        //food price
        orderView.priceLabel.text = "Price: HK$";
        orderView.price.text  = "\(model.food.price)";
        
        //food status
        orderView.statusLable.text = "Status:";
        orderView.status.text = model.food.status == 1 ? Helper.Localized(key: "food_onSale") : Helper.Localized(key: "food_soldOut");
        newFoodStatus = FoodStatus(rawValue: model.food.status);
        
        //picker view setting
        orderView.statusPickerView.delegate = self;
        orderView.statusPickerView.dataSource = self;
        
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(orderView);
        
        orderView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide);
        }
        
        let editButton = UIBarButtonItem(image: UIImage(named: "icon-edit-white"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(enableEdit));
        
        let sharButton = UIBarButtonItem(image: UIImage(named: "icon-share"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(share));
        self.navigationItem.rightBarButtonItems = [editButton, sharButton];
        
        //food image select action
        orderView.foodImageButton.reactive.controlEvents(.touchUpInside).observe { _ in
            let bottomSheet =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet);
            
            let gallery = UIAlertAction(title: Helper.Localized(key: "permission_gallery"), style: .default, handler: { _ in
                //open gallery
                if !Helper.isGalleryPermissionGranted() {
                    self.requestPermission(title: nil);
                }
            });
            
            let camera = UIAlertAction(title: Helper.Localized(key: "permission_camera"), style: .default, handler: { _ in
                //open camera
                if !Helper.isCameraPermissionGranted() {
                    self.requestPermission(title: nil);
                }
            });
            
            let cancel = UIAlertAction(title: Helper.Localized(key: "common_cancel"), style: .cancel, handler: { _ in
                //dismiss sheet
                bottomSheet.dismiss(animated: true, completion: nil);
            })
            
            bottomSheet.addAction(gallery);
            bottomSheet.addAction(camera);
            bottomSheet.addAction(cancel);
            
            self.present(bottomSheet, animated: true, completion: nil);
        }
        
        //update button logic
        orderView.confirmButton.reactive.controlEvents(.touchUpInside).observe { _ in
            let name = self.orderView.foodTitle.text;
            let price = Int(self.orderView.price.text!);
            let image = self.orderView.food.image;
            let type = FoodType(rawValue: self.model.food.type);
            
            let newVal = Food(name: name!, price: price!, image: image!, type: type!, status: self.newFoodStatus);
            StorageHelper.updateFoods(old: self.model.food, new: newVal);
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        orderView.editMode(isEdit: false);
    }
    
    @objc func enableEdit() {
        orderView.editMode(isEdit: true);
    }
    
    @objc func share() {
        
        // set up activity view controller
        let tobeShare = [""];
        let activityViewController = UIActivityViewController(activityItems: tobeShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - picker view delegate, datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.status.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.status[row].name;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let newStaus = "\(model.status[row].name ?? "")";
        orderView.status.text = newStaus;
        newFoodStatus = FoodStatus(rawValue: model.status[row].value);
    }
    

}
