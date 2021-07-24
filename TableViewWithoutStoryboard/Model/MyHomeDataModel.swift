//
//  MyHomeDataModel.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import Foundation
import UIKit

class MyHomeDataModel: NSObject {
    public var userId: String?
    public var userName: String?
    public var profileImage: String?
    public var title: String?
    public var descriptions:String?
    required public init?(dictionary: NSDictionary) {
            self.userId = Utility.getFormatterValue(value: dictionary["userId"]!) as? String
        self.userName = Utility.getFormatterValue(value: dictionary["userName"]!) as? String
        self.profileImage = Utility.getFormatterValue(value: dictionary["profileImage"]!) as? String
        self.title = Utility.getFormatterValue(value: dictionary["title"]!) as? String
        self.descriptions = Utility.getFormatterValue(value: dictionary["description"]!) as? String
      }
}
