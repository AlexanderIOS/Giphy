//
//  API.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 30.09.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import Foundation

class API {
    
    static var apiKey: String {
        return "aGKkYnS3HeYqvePsazj85s9sDGSmmArp"
    }
    
    static private var host: String {
        return "https://api.giphy.com"
    }
    
    static var trending: String {
        return host + "/v1/gifs/trending"
    }
    
    static var search: String {
        return host + "/v1/gifs/search"
    }
}
