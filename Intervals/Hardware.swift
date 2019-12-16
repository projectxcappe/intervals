//
//  Hardware.swift
//  Intervals
//
//  Created by Cass Pangell on 12/15/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//


import Foundation

func loadIntervalFile() {
    let filename = "Intervals"
    let bundle = Bundle.main
    let path = bundle.path(forResource: filename, ofType: "json")
    do {
        let content = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
    } catch {
        print("Inverval File Not Found")
    }
}

func loadIntervalFile(filename fileName: String) -> [Intervals]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.interval
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

//func readJSONFromFile(fileName: String) -> Any?
//{
//    var json: Any?
//    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
//        do {
//            let fileUrl = URL(fileURLWithPath: path)
//            // Getting data from JSON file using the file URL
//            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
//            json = try? JSONSerialization.jsonObject(with: data)
//        } catch {
//            // Handle error here
//        }
//    }
//    return json
//}


