//
//  NYCSchoolsViewModel.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation

protocol SchoolsProtocol {
    func getSchools()
    var schools: Box<[NYCSchools]> { get set }
    var didError:Box<Bool> { get set }
    var isLoading:Box<Bool> { get set }
}

class SchoolsViewModel:SchoolsProtocol {
    
    /* View model powering the table view */
    
    var schools = Box<[NYCSchools]>([])
    var didError = Box(false)
    var isLoading = Box(false)
    
    init(){
        getSchools()
    }
    
    func getSchools(){
        isLoading.value = true
        didError.value = false
        NYCSchoolsService.schoolsInNyc { [weak self] schools, error in
            self?.isLoading.value = false
            guard error == nil else {
                self?.didError.value = true
                return
            }
            
            guard let schools = schools else {
                self?.didError.value = true
                return
            }
            self?.schools.value = schools
        }
    }
}
