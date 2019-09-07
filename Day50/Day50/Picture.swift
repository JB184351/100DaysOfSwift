//
//  Picture.swift
//  Day50
//
//  Created by Justin Bengtson on 9/4/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
