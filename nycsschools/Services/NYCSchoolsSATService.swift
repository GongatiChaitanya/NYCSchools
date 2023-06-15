//
//  NYCSchoolsSATService.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation

class NYCSchoolsSATService  {
    
    /*
     SAT results service to get the schools from the endpoint
     */
    static private let SATResultsURL = URL(string: Constants.schoolWithSATScoreURL)!
    typealias SchoolResultsCompletion = ([NYCSchoolsSATResult]?,NYCOpenDataError?) -> ()
    
    static func resultsOfSchool(completion: @escaping SchoolResultsCompletion){
        let _ = ReachabilityService.makeRequest(withURL: Self.SATResultsURL) { data, error in
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
                let results = try decoder.decode([NYCSchoolsSATResult].self, from: data)
                completion(results,nil)
            } catch let error {
                print("The error is \(error)")
                completion(nil,.invalidData)
            }
        }
    }
}
