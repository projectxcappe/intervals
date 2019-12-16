//
//  Models.swift
//  Intervals
//
//  Created by Cass Pangell on 12/15/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import Foundation

struct ResponseData: Decodable {
    var interval: [Intervals]
}

struct Intervals : Decodable {
    var root: String
    var m2: String
    var M2: String
    var m3: String
    var M3: String
    var P4: String
    var TT: String
    var P5: String
    var m6: String
    var M6: String
    var m7: String
    var M7: String
    var P8: String
}

