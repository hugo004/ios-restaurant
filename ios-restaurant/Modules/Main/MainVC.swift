//
//  MainVC.swift
//  ios-restaurant
//
//  Created by Ng Chi Kin on 3/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import ImageSlideshow

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tv : UITableView!
    var nearByCv : UICollectionView!
    
    var table0 = ["imageSlide"]
    var table1 = ["Near by you"]
    var table2 = ["Type"]
    var table3 = ["New Add"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()

        // Do any additional setup after loading the view.
    }
    
    func initView() -> Void {
        self.view.backgroundColor = UIColor.white
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tv = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight),style: .grouped)
        tv.dataSource = self
        tv.delegate = self
        tv.sectionFooterHeight = 0
        
        self.view.addSubview(tv)
    }
    
    func imageSlideView(images:[ImageSource]) -> UIView {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        
        let slideshow = ImageSlideshow()
        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "t1")!),
            ImageSource(image: UIImage(named: "t2")!)
            ])
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.white
        pageIndicator.pageIndicatorTintColor = UIColor(named: "#cccccc")
        pageIndicator.numberOfPages = slideshow.images.count
        slideshow.pageIndicator = pageIndicator
        
        slideshow.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: 200)
        slideshow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .left(padding: 20), vertical: .bottom)
        
        return slideshow
        //self.view.addSubview(slideshow)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0: return 0
        case 1: return 10
        case 2: return 10
        case 3: return 10
        default:return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return " "
        case 1: return " "
        case 2: return " "
        case 3: return " "
        default:return " "
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none // 選取的時侯無背景色
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 30)
        }
        
        cell?.textLabel?.text = "123"
        
        return cell!
    }
    

}
