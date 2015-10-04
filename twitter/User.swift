//
//  User.swift
//  twitter
//
//  Created by Marco Sgrignuoli on 10/3/15.
//  Copyright © 2015 Optimizely. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screenname"] as? String
        profileImageUrl = dictionary["profileImageUrl"] as? String
        profileImageUrl = dictionary["profileImageUrl"] as? String
        tagLine = dictionary["tagLine"] as? String
    }
}
