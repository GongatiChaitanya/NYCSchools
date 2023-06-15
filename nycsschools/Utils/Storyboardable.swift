//
//  Storyboardable.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import UIKit

protocol Storyboardable {
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
    /* Used to init the storyboard files, can be avoided by using xib's and having init on the view controller itself */
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
