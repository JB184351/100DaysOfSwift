//
//  Person.swift
//  Project10
//
//  Created by Justin Bengtson on 8/26/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
