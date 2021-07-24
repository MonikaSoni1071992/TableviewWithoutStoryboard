//
//  AppConstants.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import Foundation
import UIKit

struct ScreenSize {
    static let width: CGFloat=UIScreen.main.bounds.width
    static let height: CGFloat=UIScreen.main.bounds.height
}
struct DeviceType {
    static let ISIPAD = UIDevice.current.userInterfaceIdiom == .pad
}
struct AppMessage {
    static let msgInternetNotavailable: String = "No internet connection available"
    static let msgOk: String = "OK"
    static let msgRefreshData: String = "Refresh  Data"
    static let msgDataLoadingErr: String = "Unable to load data please try again !"
}
enum ApiMethodType: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
// MARK: ALL API'S AND ROOT URL
struct WEBURL {
    static let BaseURL: String  = "https://mocki.io/v1/"
    static let HomeUrlEndPoint: String = "\(BaseURL)7c863921-3d3a-4f23-9dad-6fffb3847165"
}
