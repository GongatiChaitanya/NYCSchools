//
//  NYCSchoolsResultsViewModel.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation

protocol ResultsProtocol {
    func getSATResults()
    var satResult:Box<[NYCSchoolsSATResult]> { get set }
    var mathScore:Box<String?> { get set }
    var readingScore:Box<String?> { get set }
    var writingScore:Box<String?> { get set }
    var schoolName:Box<String?> { get set }
    func getCurrentSchoolResults(withSchoolName:String?,withSchoolID id: String)
}

class NYCSchoolsResultsViewModel:ResultsProtocol {
    /* View model powering the results view contoller */
    
    var satResult       = Box<[NYCSchoolsSATResult]>([])
    var mathScore       = Box<String?>(nil)
    var schoolName      = Box<String?>(nil)
    var readingScore    = Box<String?>(nil)
    var writingScore    = Box<String?>(nil)
    
    init(){
        getSATResults()
    }
    
    
    func getSATResults(){
        NYCSchoolsSATService.resultsOfSchool { results, error in
            guard error == nil else {
                return
            }
            
            guard let results = results else {
                return
            }
            self.satResult.value = results
        }
    }
    
    func getCurrentSchoolResults(withSchoolName:String? ,withSchoolID id: String) {
        let foundSchool = satResult.value.first(where: { result in
            guard let currentID = result.id else {return false}
            if currentID.uppercased() == id.uppercased() {
                return true
            }
            return false
        })
        if let name = foundSchool?.schoolName {
            schoolName.value = name
        }else{
            schoolName.value = withSchoolName
        }
        mathScore.value = foundSchool?.satMathAvgScore
        readingScore.value = foundSchool?.satCriticalReadingAvgScore
        writingScore.value = foundSchool?.satWritingAvgScore
    }
}
