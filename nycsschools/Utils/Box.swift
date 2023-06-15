//
//  Box.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import Foundation
final class Box<T>{
    /*
     This class is used for data binding thru the use of Boxing, this uses property observers to notify any observers that the value has changed
     
     */
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value:T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value:T){
        self.value = value
    }
    
    func bind(listener:Listener?){
        self.listener = listener
        listener?(value)
    }
}
