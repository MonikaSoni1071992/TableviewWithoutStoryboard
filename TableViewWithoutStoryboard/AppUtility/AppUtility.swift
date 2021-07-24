//
//  AppUtility.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

class Utility: NSObject {
    // MARK: - Global alert Methods
    static func showAlertMessageWithOkButtonAndTitle(_ strTitle: String, andMessage strMessage: String) {
        if objc_getClass("UIAlertController") == nil {
            let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: AppMessage.msgOk, style: .default, handler: nil)
            alert.addAction(action)
        } else {
            let alertController: UIAlertController=UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: AppMessage.msgOk, style: .default) { _ in
                if strMessage == AppMessage.msgInternetNotavailable {
                    print("Opening Wi-Fi settings.")
                    let shared = UIApplication.shared
                    let url = URL(string: "App-Prefs:root=WIFI") // for WIFI setting app
                    if #available(iOS 10.0, *) {
                        shared.open(url!)
                    } else {
                        shared.openURL(url!)
                    }
                }
            }
            alertController.addAction(ok)
            alertController.view.layer.shadowColor = UIColor.black.cgColor
            alertController.view.layer.shadowOpacity = 0.8
            alertController.view.layer.shadowRadius = 5
            alertController.view.layer.shadowOffset = CGSize(width: 0, height: 0)
            alertController.view.layer.masksToBounds = false
            let topWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            topWindow.rootViewController = UIViewController()
            topWindow.windowLevel = UIWindow.Level.alert + 1
            topWindow.makeKeyAndVisible()
            topWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Internet Connection Checking Methods
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    class func setNavigationBarColor (color: UIColor) {
        UINavigationBar.appearance().tintColor = color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
    class func setBarButtonColor (color: UIColor) {
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .highlighted)
    }
    class func showAlertWithMessage (viewCtr: UIViewController, msg: String) {
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let action2 = UIAlertAction(title: "OK", style: .cancel) { _ in
            print("You've pressed cancel")
        }
        alertController.addAction(action2)
        viewCtr.present(alertController, animated: true, completion: nil)
    }
    class func getFormatterValue(value: Any) -> Any {
        if value is NSNull {
            return String()
        } else if value is NSNumber {
            let num = value as? NSNumber
            return num?.stringValue as Any
        } else if value is NSString {
            let newValue = value as? String
            let newValueSmallCase = newValue!.caseInsensitiveCompare("null")
            let newValueUpperCase = newValue!.caseInsensitiveCompare("(null)")
            if newValueSmallCase == ComparisonResult.orderedSame || newValueUpperCase == ComparisonResult.orderedSame {
                return String()
            } else {
                return value
            }
        } else {
            return value
        }
    }
    // MARK: Function to set loader on tableview
    class func refresh(tableName: UITableView) -> UIRefreshControl {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        let attributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
        refreshControl.attributedTitle = NSAttributedString(string: AppMessage.msgRefreshData, attributes: attributes)
        refreshControl.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        tableName.addSubview(refreshControl)
        return refreshControl
    }
}
