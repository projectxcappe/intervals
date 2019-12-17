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
    var song: [Song]
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

struct Song : Decodable {
    var m2_asc: String
    var M2_asc: String
    var m3_asc: String
    var M3_asc: String
    var P4_asc: String
    var TT_asc: String
    var P5_asc: String
    var m6_asc: String
    var M6_asc: String
    var m7_asc: String
    var M7_asc: String
    var P8_asc: String
    
    var m2_dec: String
    var M2_dec: String
    var m3_dec: String
    var M3_dec: String
    var P4_dec: String
    var TT_dec: String
    var P5_dec: String
    var m6_dec: String
    var M6_dec: String
    var m7_dec: String
    var M7_dec: String
    var P8_dec: String
}

