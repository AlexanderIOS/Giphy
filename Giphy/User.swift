//
//  User.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import RealmSwift
import ObjectMapper

final class User: Object, Mappable {
    
    @objc dynamic var name: String?
    @objc dynamic var gifName: String?
    
    // Mappable
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name        <- map["username"]
        gifName     <- map["display_name"]
    }
}
