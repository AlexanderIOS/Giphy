//
//  Extension+Gif.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 02.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import UIKit
import Foundation

extension Gif {
    
    func share(with controller: UIViewController) {
        guard let shareURL = URL(string: self.gifUrl),
            let shareData = try? Data(contentsOf: shareURL)
            else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
        controller.present(activityViewController, animated: true, completion: nil)
    }

    
}
