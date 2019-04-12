//
//  RestaurantInfoView.swift
//  ios-restaurant
//
//  Created by rzc on 5/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import SnapKit

protocol MapViewDelegate {
    func callMapView()
}

class RestaurantInfoView: UIView {
    let screenSize: CGRect = UIScreen.main.bounds
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

    let contactLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 20, width: 300, height: 70))
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.text = Helper.Localized(key: "r_title")
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    let coverImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "restaurant-1")
//        imgView.frame = CGRect(x: 0, y: 0, width:  self.view.frame.width, height: 200)
        return imgView
    }()

    
//    let mapBtn: UIButton = {
//        let btn = UIButton(frame: CGRect(x: 20, y: 260, width: 250, height: 40))
////        btn.font = .systemFont(ofSize: 14, weight: .bold)
//        btn.setTitle(Helper.Localized(key: "r_map_btn"), for: .normal)
//        btn.backgroundColor = UIColor.yellow
//
//        btn.setTitleColor(UIColor.blue, for: .normal)
//
//       return btn
//    }()
    
    let cat: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 38, weight: .bold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let phoneLbl1: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 80, width: 140, height: 70))
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = Helper.Localized(key: "r_contact_no")
        return lbl
    }()
    
    let addressLbl1: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 120, width: 140, height: 70))
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = Helper.Localized(key: "r_address")
        return lbl
    }()
    
    let phoneLbl2: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 155, y: 80, width: 140, height: 70))
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        lbl.text = "26608600"
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let addressLbl2: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 155, y: 150, width: 200, height: 100))
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        lbl.numberOfLines = 0
        lbl.text = Helper.Localized(key: "r_address1")
        lbl.lineBreakMode = .byTruncatingTail
        
        return lbl
    }()
    
    let uiv: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 200, width: 500, height: 300))
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.init(red: 229, green: 227, blue: 227, alpha: 1.0)
        view.layer.borderColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 ).cgColor
        
        return view
    }()
    
    
    
//    @objc func callMapView() {
//                let mapv = MapViewController()
//                print("clicked btn")
//                self.navigationController?.pushViewController(mapv, animated: true)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let screenSize: CGRect = UIScreen.main.bounds
//        //handle child view
        uiv.addSubview(contactLbl)
        uiv.addSubview(phoneLbl1)
        uiv.addSubview(addressLbl1)
        uiv.addSubview(phoneLbl2)
        uiv.addSubview(addressLbl2)
//        uiv.addSubview(mapBtn)
//        phoneLbl1.translatesAutoresizingMaskIntoConstraints = false
//        addressLbl1.translatesAutoresizingMaskIntoConstraints = false
//        phoneLbl2.translatesAutoresizingMaskIntoConstraints = false
//        addressLbl2.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = NSLayoutConstraint(item: phoneLbl1, attribute: .centerX, relatedBy: .equal, toItem: uiv, attribute: .centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: phoneLbl1, attribute: .centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: uiv, attribute: .centerY, multiplier: 1, constant: 0)
//        uiv.addConstraint(horizontalConstraint)
//        uiv.addConstraint(verticalConstraint)
//        uiv.addConstraints([horizontalConstraint, verticalConstraint])
//        NSLayoutConstraint.activate([phoneLbl1.centerXAnchor.constraint(equalTo: uiv.centerXAnchor)])
//        NSLayoutConstraint.activate([phoneLbl1.centerYAnchor.constraint(equalTo: uiv.centerYAnchor)])
//        NSLayoutConstraint.activate([phoneLbl1.widthAnchor.constraint(equalToConstant: 200)])
//        NSLayoutConstraint.activate([phoneLbl1.heightAnchor.constraint(equalToConstant: 100)])
        
        
//        uiv.addSubview(addressLbl1)

        
//        phoneLbl1.snp.makeConstraints { (make) in
////            make.left.equalTo(self).offset(0)
////            make.top.equalTo(self.coverImgView).offset(0)
////            make.right.equalTo(self).offset(0)
//            make.height.equalTo(70)
//            make.width.equalTo(140)
//        }
//        addressLbl1.snp.makeConstraints { (make) in
//            make.left.equalTo(superview!).offset(0)
////            make.top.equalTo(phoneLbl1.snp_bottom).offset(12)
//            make.right.equalTo(superview!).offset(0)
//            make.height.equalTo(70)
//            make.width.equalTo(140)
//        }
//        phoneLbl2.snp.makeConstraints { (make) in
//            make.left.equalTo(superview!).offset(24)
//            make.top.equalTo(superview!).offset(0)
//            make.right.equalTo(superview!).offset(0)
//            make.height.equalTo(70)
//            make.width.equalTo(140)
//        }
//        addressLbl2.snp.makeConstraints { (make) in
//            make.left.equalTo(superview!).offset(24)
//            make.top.equalTo(superview!).offset(12)
//            make.right.equalTo(superview!).offset(0)
//            make.height.equalTo(70)
//            make.width.equalTo(140)
//        }
        
        // end of uiv
        coverImgView.frame = CGRect(x: 0, y: 0, width:  screenSize.width, height: 200)
        self.addSubview(coverImgView)
        self.addSubview(uiv)
        
        

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
