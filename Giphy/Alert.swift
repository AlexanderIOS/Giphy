//
//  Alert.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import UIKit

struct Alert {
    
    static func present(title: String?, actions: [UIAlertAction]? = nil, from controller: UIViewController?, preferredStyle: UIAlertControllerStyle = .alert) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: preferredStyle)
        
        if let actions = actions, actions.count > 0 {
            for action in actions {
                alert.addAction(action)
            }
            
        } else {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
        }
        
        controller?.present(alert, animated: true, completion: nil)
    }
}
