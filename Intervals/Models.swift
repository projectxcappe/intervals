//
//  Models.swift
//  Intervals
//
//  Created by Cass Pangell on 12/15/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import Foundation

struct ResponseData: Decodable {
    var interval_data: IntervalData
}

struct IntervalData: Decodable {
    var Ascending: [Intervals]
    var Decending: [Intervals]
    var Song: Song
    var Chord: Chord
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

enum IntervalList: String, CaseIterable {
    
    case root, m2, M2, m3, M3, P4, TT, P5, m6, M6, m7, M7, P8
    
    static var getRandomInterval: String {
        return allCases.randomElement()!.rawValue
    }
}

struct Song : Decodable {
    var SongAscending: SongAscending
    var SongDecending: SongDecending
}

struct SongAscending : Decodable {
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

struct SongDecending : Decodable {
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

struct Chord : Decodable {
    var Major: Triads
    var Minor: Triads
    var Seventh: Sevenths
}

struct Triads : Decodable {
    var Triad_Root: [[String]]
    var Triad_1st: [[String]]
    var Triad_2nd: [[String]]
}

struct Sevenths : Decodable {
    var Major : [[String]]
    var Minor : [[String]]
    var Dominant : [[String]]
    var Full_Diminished : [[String]]
    var Half_Diminished : [[String]]
}
