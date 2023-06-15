//
//  ReachabilityService.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation
protocol Cancelable {
    func cancel()
}

class ReachabilityService {
    /*
     Networking layer to make URL session called , if more time is provided, we can add caching to avoid too many network calls and also use the cancel to cancel tasks which are not required
     
     We can also add a database layer to store all the result ( eg core data )
     */
    typealias networkDataCompletion = (Data?,NYCOpenDataError?) -> ()
    static func makeRequest(withURL url:URL, completion:@escaping networkDataCompletion)-> Cancelable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil,.failedRequest)
                return
            }
            guard let data = data else {
                completion(nil,.noData)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(nil,.invalidResponse)
                return
            }
            guard response.statusCode == 200 else {
                completion(nil,.failedRequest)
                return
            }
            completion(data,nil)

        }
        dataTask.resume()
        return dataTask
    }
}

extension URLSessionTask :Cancelable {
    
}
