//
//  MainVC.swift
//  ios-restaurant
//
//  Created by Ng Chi Kin on 3/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreLocation




private let identifier  = "Cell"
private let nearcollectionIdentifier  = "nearcoCell"
private let addcollectionIdentifier  = "addcoCell"
private let morecollectionIdentifier  = "morecoCell"

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    var tv : UITableView!
    var nearByCv : UICollectionView!
    var addAddCv : UICollectionView!
    var moreCv : UICollectionView!
    var horizontalCollectionViewFlowLayout: UICollectionViewFlowLayout!
    var verticalCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var rsDatas : [Restaurant]!
    
    var nearData : [Restaurant] = [];
    var nearDin : [Double] = [];
    var newData : [Restaurant] = [];
    var moreData : [Restaurant] = [];
    
    var table0 = ["imageSlide"]
    var table1 = ["Near by you"]
    var table2 = ["New Add"]
    var table3 = ["More"]
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var isUpdatingLocation = false
    var lastLocationError: Error?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        StorageHelper.initRestaurantData()
        rsDatas = StorageHelper.getRestaurant()
        
        //findLocation()
        checkData(rss:rsDatas)
        
        initView()

        // Do any additional setup after loading the view.
    }
    
    func findLocation() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authorizationStatus == .denied || authorizationStatus == .restricted {
            reportLocationServicesDeniedError()
            return
        }
        
        if isUpdatingLocation {
            stopLocationManager()
        } else{
            location = nil
            lastLocationError = nil
            startLocationManger()
        }
    }
    
    func startLocationManger() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
    
    func stopLocationManager(){
        if isUpdatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            isUpdatingLocation = true
        }
    }
    
    func reportLocationServicesDeniedError() {
        let alert = UIAlertController(title: "Location Services Disabled.", message: "Please go to Setting > Privacy to enable location services for this app.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert,animated: true,completion: nil)
    }

    
    func checkData(rss: [Restaurant]) {
        var myLocation = CLLocation(latitude: CLLocationDegrees(22.3361705), longitude: CLLocationDegrees(114.1742634))
        
        for i in 0...rss.count-1 {
            var rsLocation = CLLocation(latitude: CLLocationDegrees(rss[i].lat), longitude: CLLocationDegrees(rss[i].long))
            let distance = myLocation.distance(from: rsLocation) / 1000
            
            if rss[i].name == "品香樓中西風味餐廳 Ban Heung Lau"{
                newData.append(rss[i])
            }else if rss[i].name == "榕記車仔麵 Yung Kee" {
                newData.append(rss[i])
            }else if distance < 1 {
                nearData.append(rss[i])
                nearDin.append(distance)
            }else {
                moreData.append(rss[i])
            }
        }
        
        
    }
    
    
    func initView() -> Void {
        self.view.backgroundColor = UIColor.white
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        
        tv = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight),style: .grouped)
        tv.register(MainTableViewCell.self, forCellReuseIdentifier: identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.sectionFooterHeight = 0
        tv.allowsSelection = false
        
        self.view.addSubview(tv)
        
        tv.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide);
        }
    }
    
    func imageSlideView(images:[ImageSource]) -> UIView {
        //let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        
        let slideshow = ImageSlideshow()
        slideshow.setImageInputs(images)
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.white
        pageIndicator.pageIndicatorTintColor = UIColor(named: "#cccccc")
        pageIndicator.numberOfPages = slideshow.images.count
        slideshow.pageIndicator = pageIndicator
        
        slideshow.frame = CGRect(x: 0, y: 0, width: displayWidth, height: 200)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = moreData.count
        let height = 230*count+40+20*count
        if indexPath.section == 0 {
            return 200
        }else if indexPath.section == 1 {
            return 240
        }else if indexPath.section == 2 {
            return 240
        }else if indexPath.section == 3 {
            return CGFloat(height)
        }
        return 60
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
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MainTableViewCell
        
        if indexPath.section == 0 {
            cell.contentView.addSubview(imageSlideView(images: [
                ImageSource(image: UIImage(named: "P1")!),
                ImageSource(image: UIImage(named: "P2")!)
                ]))
            cell.backgroundColor = UIColor.black
        }else if indexPath.section == 1 {
            cell.lblTitle.text = "Restaurant near by you"
            cell.addSubview(nearbyCollectionView())
            
        }else if indexPath.section == 2 {
            cell.lblTitle.text = "New Add"
            cell.addSubview(newAddCollectionView())
            
        }
            
        else if indexPath.section == 3 {
            cell.lblTitle.text = "More"
            cell.addSubview(moreCollectionView())
        }
        
        return cell
    }
    
    func horizontalCollectionViewLayoutSetup() -> UICollectionViewFlowLayout {
        let itemSpace: CGFloat = 20
        let itemWidth: CGFloat = 230
        let itemHeight: CGFloat = 240
        
        horizontalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        horizontalCollectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        horizontalCollectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        horizontalCollectionViewFlowLayout.scrollDirection = .horizontal
        horizontalCollectionViewFlowLayout.minimumInteritemSpacing = itemSpace
        
        return horizontalCollectionViewFlowLayout
    }
    
    func verticalCollectionViewLayoutSetup() -> UICollectionViewFlowLayout {
        let itemSpace: CGFloat = 15
        let itemWidth: CGFloat = self.view.frame.width - 40
        let itemHeight: CGFloat = 230
        
        verticalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        verticalCollectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        verticalCollectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        verticalCollectionViewFlowLayout.scrollDirection = .vertical
        verticalCollectionViewFlowLayout.minimumLineSpacing = itemSpace
        
        return verticalCollectionViewFlowLayout
    }
    
    func nearbyCollectionView() -> UIView {
        let displayWidth: CGFloat = self.view.frame.width
        nearByCv = UICollectionView(frame: CGRect(x: 0, y: 40, width: displayWidth, height: 200), collectionViewLayout: horizontalCollectionViewLayoutSetup())
        nearByCv.delegate = self
        nearByCv.dataSource = self
        nearByCv.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: nearcollectionIdentifier)
        nearByCv.backgroundColor = UIColor.white
        nearByCv.showsHorizontalScrollIndicator = false
        
        
        return nearByCv
    }
    
    func newAddCollectionView() -> UIView {
        let displayWidth: CGFloat = self.view.frame.width
        addAddCv = UICollectionView(frame: CGRect(x: 0, y: 40, width: displayWidth, height: 200), collectionViewLayout: horizontalCollectionViewLayoutSetup())
        addAddCv.delegate = self
        addAddCv.dataSource = self
        addAddCv.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: addcollectionIdentifier)
        addAddCv.backgroundColor = UIColor.white
        addAddCv.showsHorizontalScrollIndicator = false
        
        
        return addAddCv
    }
    
    func moreCollectionView() -> UIView {
        let count = moreData.count
        let height = 230*count+40+10*count
        let displayWidth: CGFloat = self.view.frame.width
        moreCv = UICollectionView(frame: CGRect(x: 0, y: 40, width: Int(displayWidth), height: height), collectionViewLayout: verticalCollectionViewLayoutSetup())
        moreCv.delegate = self
        moreCv.dataSource = self
        moreCv.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: morecollectionIdentifier)
        moreCv.backgroundColor = UIColor.white
        moreCv.showsHorizontalScrollIndicator = false
        
        
        return moreCv
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.addAddCv {
            return newData.count
        }else if collectionView == self.moreCv {
           return moreData.count
        }else {
            return newData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.addAddCv {
            let coCell = addAddCv.dequeueReusableCell(withReuseIdentifier: addcollectionIdentifier, for: indexPath) as! HorizontalCollectionViewCell
            coCell.imageView.image = UIImage(data: newData[indexPath.row].img!)
            coCell.lblName.text = newData[indexPath.row].name
            return coCell
        }else if collectionView == self.nearByCv{
            let coCell = nearByCv.dequeueReusableCell(withReuseIdentifier: nearcollectionIdentifier, for: indexPath) as! HorizontalCollectionViewCell
            coCell.imageView.image = UIImage(data: nearData[indexPath.row].img!)
            coCell.lblDistance.text = "\(String(format:"%f", nearDin[indexPath.row])) km"
            coCell.lblName.text = nearData[indexPath.row].name
            
            return coCell
        }else{
            let coCell = moreCv.dequeueReusableCell(withReuseIdentifier: morecollectionIdentifier, for: indexPath) as! VerticalCollectionViewCell
            coCell.imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-40, height: 200)
            coCell.lblName.frame = CGRect(x: 0, y: 210, width: self.view.frame.width-40, height: 20)
            coCell.lblName.text = rsDatas[indexPath.row].name
            coCell.imageView.image = UIImage(data: rsDatas[indexPath.row].img!)
            
            return coCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MapViewController()
        vc.restaurant = rsDatas[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        lastLocationError = error
        stopLocationManager()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        //print(location!.coordinate.latitude)
        //print(location!.coordinate.longitude)
        checkData(rss:rsDatas)
        stopLocationManager()
        
    }
    
}
