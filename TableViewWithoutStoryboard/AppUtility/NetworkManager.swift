//
//  NetworkManager.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    private var jsonStrings: String?
    func executeServiceWithURL(showIndicator: Bool, methodType: String, urlString: String, postParameters: NSDictionary?, callback: @escaping (_ json:[AnyObject]?, _ taskError:NSError?) -> Void) {

        if Utility.isInternetAvailable() == false {
            callback(nil, nil)
            Utility.showAlertMessageWithOkButtonAndTitle("Info", andMessage: AppMessage.msgInternetNotavailable)
            return
        } else {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.window?.isUserInteractionEnabled = false
            }
        }

        if showIndicator {
            DispatchQueue.main.async {
                // Utility.showIndicator()
            }
        }
        if postParameters != nil {
            do {
                let json = try JSONSerialization.data(withJSONObject: postParameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
                jsonStrings  = String(data: json, encoding: String.Encoding.utf8)!
            } catch let error as NSError {
                print("Error : - \(error.localizedDescription)")
            }
        }
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = methodType
        if postParameters != nil {
            let jsonData = try? JSONSerialization.data(withJSONObject: postParameters!, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            request.httpBody = jsonString.data(using: String.Encoding.utf8)!
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request as URLRequest) {(taskData, _ taskResponse, _ taskError) in DispatchQueue.main.async {
               // Utility.hideIndicator()
              if let delegate = UIApplication.shared.delegate as? AppDelegate {
                    delegate.window?.isUserInteractionEnabled = true
                }
                do {
                    if taskData != nil {
                        guard let json = try JSONSerialization.jsonObject(with: taskData!, options: []) as? [AnyObject] else {
                            return
                        }
                        callback(json, nil)
                    } else {
                        callback(nil, taskError as NSError?)
                    }
                } catch let error as NSError {
                    callback(nil, error)
                }
            }
        }
        dataTask.resume()
    }
}
