//
//  Favorite.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import RealmSwift

final class Favorite: Object {
    
    let gifs = List<Gif>()
    
    var allGifs: [Gif] {
        return Array(gifs)
    }
}
