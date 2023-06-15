//
//  NYCSchoolsSATResult.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation

struct NYCSchoolsSATResult :Codable {
    let id:String?
    let schoolName:String?
    let numOfSatTestTakers:String?
    let satCriticalReadingAvgScore:String?
    let satMathAvgScore:String?
    let satWritingAvgScore:String?
    
    enum CodingKeys: String, CodingKey {
        case schoolName
        case id = "dbn"
        case numOfSatTestTakers
        case satCriticalReadingAvgScore
        case satMathAvgScore
        case satWritingAvgScore
    }
}
