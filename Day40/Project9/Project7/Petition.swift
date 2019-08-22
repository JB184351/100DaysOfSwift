//
//  Petition.swift
//  Project7
//
//  Created by Justin Bengtson on 8/15/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
