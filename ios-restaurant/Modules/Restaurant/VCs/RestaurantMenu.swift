//
//  RestaurantMenu.swift
//  ios-restaurant
//
//  Created by rzc on 7/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import Parchment

class RestaurantCustView: PagingView {
    var headerHeightConstraint: NSLayoutConstraint?
    var riv: RestaurantInfoView!
    
    static let HeaderHeight: CGFloat = 500
    

    
    override func setupConstraints() {
        
        riv = RestaurantInfoView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 50))
        riv.sizeToFit()
        addSubview(riv)
        pageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        riv.translatesAutoresizingMaskIntoConstraints = false
        
        headerHeightConstraint = riv.heightAnchor.constraint(
            equalToConstant: RestaurantCustView.HeaderHeight
        )
        headerHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
            collectionView.topAnchor.constraint(equalTo: riv.bottomAnchor),
            
            riv.topAnchor.constraint(equalTo: topAnchor),
            riv.leadingAnchor.constraint(equalTo: leadingAnchor),
            riv.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageView.topAnchor.constraint(equalTo: topAnchor)
            ])
    }
}

class CustomPagingViewController: PagingViewController<PagingIndexItem> {
    
    override func loadView() {
        view = RestaurantCustView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}
class RestaurantMenu: UIViewController, UINavigationControllerDelegate  {
    let screenSize: CGRect = UIScreen.main.bounds
//    var riv: RestaurantInfoView!
    var img: UIImageView!
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        return v
    }()
    private let pagingViewController = CustomPagingViewController()
    
    
    let mapBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20, y: 260, width: 50, height: 50))
        //        btn.font = .systemFont(ofSize: 14, weight: .bold)
//        btn.setTitle(Helper.Localized(key: "r_map_btn"), for: .normal)
        btn.setImage(UIImage(named: "map-icon"), for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.view.backgroundColor = UIColor.white;
        
        
       
        initView()
        
        
        
        self.view.addSubview(mapBtn);
        mapBtn.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20);
            make.size.equalTo(CGSize(width: 50, height: 50));
        }
        
        mapBtn.reactive.controlEvents(.touchUpInside).observe { _ in
            let vc = MapViewController();
            self.navigationController?.pushViewController(vc, animated: false)
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
    func initView() -> Void{
        
//        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//
//        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
//
        
   
//        riv = RestaurantInfoView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 50))
//        riv.sizeToFit()
        
//        riv.mapBtn.addTarget(self, action: #selector(showMap), for: .touchUpInside)
//        riv.mapBtn.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
//            let mapv = MapViewController()
//            print("clicked btn")
//            self.navigationController?.pushViewController(mapv, animated: true)
//        }

//        scrollView.addSubview(riv)
        addChild(pagingViewController)
//        scrollView.addSubview(pagingViewController.view)
//        scrollView.constrainToEdges(pagingViewController.view)
        self.view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Customize the menu styling.
        pagingViewController.selectedTextColor = .black
        pagingViewController.indicatorColor = .black
        pagingViewController.indicatorOptions = .visible(
            height: 1,
            zIndex: Int.max,
            spacing: .zero,
            insets: .zero
        )
        
        
        // Contrain the paging view to all edges.
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
//        self.view.addSubview(scrollView)
        
        
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        
    }
    
    private func menuOffset(for scrollView: UIScrollView) -> CGFloat {
        return min(pagingViewController.options.menuHeight, max(0, scrollView.contentOffset.y))
    }
    

}

extension RestaurantMenu: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        let viewController = TableViewController()
        
        // Inset the table view with the height of the menu height.
        let height = pagingViewController.options.menuHeight + RestaurantCustView.HeaderHeight
        let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        viewController.tableView.contentInset = insets
        viewController.tableView.scrollIndicatorInsets = insets
        viewController.tableView.delegate = self
        
        return viewController
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return PagingIndexItem(index: index, title: MenuCategory.allValues[index].rawValue) as! T
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int{
        return MenuCategory.allCases.count
    }
    
}

extension RestaurantMenu: PagingViewControllerDelegate {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, didScrollToItem pagingItem: T, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        guard let startingViewController = startingViewController as? TableViewController else { return }
        guard let destinationViewController = destinationViewController as? TableViewController else { return }
        
        // Set the delegate on the currently selected view so that we can
        // listen to the scroll view delegate.
        if transitionSuccessful {
            startingViewController.tableView.delegate = nil
            destinationViewController.tableView.delegate = self
        }
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, willScrollToItem pagingItem: T, startingViewController: UIViewController, destinationViewController: UIViewController) {
        guard let destinationViewController = destinationViewController as? TableViewController else { return }
        
        // Update the content offset based on the height of the header view.
        if let pagingView = pagingViewController.view as? RestaurantCustView {
            if let headerHeight = pagingView.headerHeightConstraint?.constant {
                let offset = headerHeight + pagingViewController.options.menuHeight
                destinationViewController.tableView.contentOffset = CGPoint(x: 0, y: -offset)
            }
        }
    }
    
}

extension RestaurantMenu: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y < 0 else { return }
        
        // Update the height of the header view based on the scroll view's
        // content offset.
        if let menuView = pagingViewController.view as? RestaurantCustView {
            let height = max(0, abs(scrollView.contentOffset.y) - pagingViewController.options.menuHeight)
            menuView.headerHeightConstraint?.constant = height
        }
    }
    
}
