//
//  DataManager.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import RealmSwift

final class DataManager {
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func addToFavorites(_ gif: Gif?) {
        guard let gif = gif else { return }

        if let favorite = getFavorite() {
            try? realm.write {
                favorite.gifs.insert(gif, at: 0)
            }
        } else {
            try? realm.write {
                let favorite = Favorite()
                realm.add(favorite)
                favorite.gifs.append(gif)
            }
        }
    }
    
    func deleteToFavorites(_ gif: Gif?) {
        guard let gif = gif else { return }
        
        try? realm.write {
            realm.delete(gif)
        }
    }
    
    func getFavorite() -> Favorite? {
        return realm.objects(Favorite.self).first
    }
    
    func getFavoriteGifs() -> [Gif] {
        let favorite = getFavorite()
        return favorite?.allGifs ?? []
    }
}
