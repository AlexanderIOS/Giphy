//
//  Gif.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import RealmSwift
import ObjectMapper

final class Gif: Object, Mappable {
    
    @objc dynamic var id: String?
    @objc dynamic var url: String?
    @objc dynamic var user: User?
    @objc dynamic var createDate: String?
    
    var info: String {
        let name = "Автор: \(user?.name ?? "--")"
        let gifName = "Название: \(user?.gifName ?? "--")"
        let date = "Дата создания: \(createDate ?? "--")"
        
        return "\(name)\n\(gifName)\n\(date)"
    }
    
    var gifUrl: String {
        return url ?? ""
    }
    
    // Mappable
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        mappingUrl(map)

        id          <- map["id"]
        user        <- map["user"]
        createDate  <- map["import_datetime"]
    }
    
    func mappingUrl(_ map: Map) {
        guard let images = map["images"].JSON["images"] as? [String: Any],
            let downsampled = images["fixed_width_downsampled"] as? [String: String]
            else { return }
        
        url = downsampled["url"]
    }
}
