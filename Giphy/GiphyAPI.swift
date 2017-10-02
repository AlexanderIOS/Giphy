//
//  GiphyAPI.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 30.09.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import Alamofire
import ObjectMapper

class GiphyAPI {
    
    enum Route {
        case trendingGifs(offset: Int)
        case searchingGifs(String, Int)

        var path: String {
            switch self {
            case .trendingGifs: return API.trending
            case .searchingGifs: return API.search
            }
        }
        
        var parameters: [String: Any] {
            switch self {
            case .trendingGifs(let offset):
                return ["api_key": API.apiKey, "limit": 20, "offset": offset, "fmt": "json"]
            case .searchingGifs(let text, let offset):
                return ["api_key": API.apiKey, "limit": 20, "offset": offset, "fmt": "json", "q": text]
            }
        }
    }
    
    static func trendingGifs(by offset: Int, closure: @escaping (_ handler: [Gif]?) -> Void) {
        let request = Route.trendingGifs(offset: offset)
        
        Alamofire.request(request.path, parameters: request.parameters).responseJSON { response in
            switch response.result {
            case .success(let json):
                let gifs = Mapper<Gif>().mapArray(JSONObject: (json as AnyObject).value(forKey: "data"))
                closure(gifs)
            case .failure(let error):
                print("Status code", response.response?.statusCode ?? 0)
                print("Error", error.localizedDescription)
                closure(nil)
            }
        }
    }
    
    static func searchingGifs(by text: String, and offset: Int, closure: @escaping (_ handler: [Gif]?) -> Void) {
        let request = Route.searchingGifs(text, offset)
        
        Alamofire.request(request.path, parameters: request.parameters).responseJSON { response in
            switch response.result {
            case .success(let json):
                let gifs = Mapper<Gif>().mapArray(JSONObject: (json as AnyObject).value(forKey: "data"))
                closure(gifs)
            case .failure(let error):
                print("Status code", response.response?.statusCode ?? 0)
                print("Error", error.localizedDescription)
                closure(nil)
            }
        }
    }
}
