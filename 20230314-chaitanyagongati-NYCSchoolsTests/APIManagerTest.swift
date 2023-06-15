//
//  APIManagerTest.swift
//  20230314-chaitanyagongati-NYCSchoolsTests
//
//  Created by chaitanya gongati on 3/14/23.
//

import XCTest
@testable import _0230314_chaitanyagongati_NYCSchools
final class APIManagerTest: XCTestCase {
        

        func testFetchSchools() {
            
            let exp = expectation(description: "Success Response and fetch School List Data.")
            
            NYCSchoolsService.schoolsInNyc { (resultData, error) in
                XCTAssertNil(error)
                
                guard let data = resultData else {
                        exp.fulfill()
                        
                        return
                }
                
                XCTAssert(resultData != nil, "Schools fetched.")
                exp.fulfill()
            }
            
            waitForExpectations(timeout: 3.0, handler: nil)
        }
        
        func testFetchSATScores() {
            
            let exp = expectation(description: "Success Response and fetched SAT Scores Data.")
            
            NYCSchoolsSATService.resultsOfSchool { (resultData, error) in
                XCTAssertNil(error)
                
                      guard let data = resultData else {
                              exp.fulfill()
                              
                              return
                      }
                XCTAssert(resultData != nil, "SAT Scores fetched.")
                exp.fulfill()
            }
            
            waitForExpectations(timeout: 3.0, handler: nil)
        }
    }
