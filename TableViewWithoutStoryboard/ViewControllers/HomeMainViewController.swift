//
//  HomeMainViewController.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import UIKit

class HomeMainViewController: UIViewController {
    let homeTableView = UITableView() // Table view
    var homeDataArray: NSMutableArray! = NSMutableArray.init() // for data Managment
    var refreshControl = UIRefreshControl() // variable for refresh table view
    var indicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Monika Soni"
         getApiDataForHomeScreen()
        self.initialSetupTableView()
    }
    // MARK: initialization setup of table inside main view
    func initialSetupTableView() {
        view.backgroundColor = .white
        view.addSubview(homeTableView)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.estimatedRowHeight = 200
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        homeTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        homeTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeTblCell")
        homeTableView.tableFooterView = UIView()
        self.refreshControl = Utility.refresh(tableName: homeTableView)
        self.refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    // MARK: Function for refresh table
    @objc func refreshTable() {
        self.getApiDataForHomeScreen()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
             self.homeTableView.reloadData()
        }
    }
    func activityIndicator() {
           indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        if #available(iOS 13.0, *) {
            indicator.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
            indicator.style = UIActivityIndicatorView.Style.gray
        }
           indicator.center = self.view.center
           self.view.addSubview(indicator)
       }
}
extension HomeMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTblCell", for: indexPath) as? HomeTableViewCell
        let getDataModel =  self.homeDataArray.object(at: indexPath.row) as? MyHomeDataModel
        cell!.loadHomeTableData(data: getDataModel!)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // MARK: Web service call for get all notification list
    @objc func getApiDataForHomeScreen() {
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .clear
        self.homeDataArray.removeAllObjects() // remove data to avoid append duplicate value
        NetworkManager.sharedInstance.executeServiceWithURL(showIndicator: true, methodType: ApiMethodType.get.rawValue, urlString: WEBURL.HomeUrlEndPoint, postParameters: nil, callback: {
            (json: [AnyObject]?, jsonError: NSError?) in
           // print("json data \(String(describing: json)) error \(String(describing: jsonError))")
             self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
            if json == nil {
                return
            }
            if let dictUser = json as NSArray? {
                for item in dictUser {
                    let getItemDict = item as? NSDictionary
                    let getInModel = MyHomeDataModel.init(dictionary: getItemDict!)
                    self.homeDataArray.add(getInModel as Any)
                }
                self.homeTableView.reloadData()
            } else {
                Utility.showAlertWithMessage(viewCtr: self, msg: AppMessage.msgDataLoadingErr)
            }
        })
    }
}
