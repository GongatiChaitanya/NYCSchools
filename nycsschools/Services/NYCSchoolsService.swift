//
//  NYCSchoolsService.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation
enum NYCOpenDataError:Error{
    // Custom error codes
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class NYCSchoolsService  {
    
    /*
     School service to get the schools from the endpoint
     */
    static private let schoolsURL = URL(string: Constants.schoolsURL)!
    typealias SchoolsDataCompletion = ([NYCSchools]?,NYCOpenDataError?) -> ()
    
    static func schoolsInNyc(completion: @escaping SchoolsDataCompletion){
       let _ =  ReachabilityService.makeRequest(withURL: Self.schoolsURL) { data, error in
            guard error == nil else {
                completion(nil,error)
                return
            }
            
            guard let data = data else{
                completion(nil,.invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let schools = try decoder.decode([NYCSchools].self, from: data)
                completion(schools,nil)
            } catch let error {
                print("The error is \(error)")
                completion(nil,.invalidData)
            }
        }
    }
}
