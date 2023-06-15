//
//  NYCSchoolsTableViewCell.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import UIKit

class NYCSchoolsTableViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet var cardView: UIView!    
    @IBOutlet var schoolNameLbl: UILabel!
    @IBOutlet var schoolAddrLbl: UILabel!
    @IBOutlet var schoolPhoneNum: UILabel!
    //@IBOutlet var navigateToAddrBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCardViewShadows()
        
    }
    
    func configure(withSchool school:NYCSchools){
        
        if let schoolName = school.schoolName {
            schoolNameLbl.text = schoolName
        }
        
        if let schoolAddr = school.location {
            
            schoolAddrLbl.text = "City: \(schoolAddr)"
            
            
        }
        
        if let phoneNum = school.phoneNumber{
            schoolPhoneNum.text = "Phone # \(phoneNum)"
            
            
        }
    }
    
    func setupCardViewShadows(){
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }


}
