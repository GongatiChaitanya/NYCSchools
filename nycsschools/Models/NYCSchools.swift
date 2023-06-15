//
//  NYCSchools.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation

struct NYCSchools:Codable {
    let id:String?
    let schoolName:String?
    let overviewParagraph:String?
    let phoneNumber:String?
    let city:String?
    let zip:String?
    let location:String?
    let latitude:String?
    let longitude:String?



    enum CodingKeys: String, CodingKey {
        case schoolName, overviewParagraph, phoneNumber,city,zip,location,latitude,longitude
        case id = "dbn"
    }
}
