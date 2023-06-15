//
//  NYCSchoolsResultsViewController.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import UIKit

class NYCSchoolsResultsViewController: UIViewController,Storyboardable {
    /* VC to show the results of the SAT scores */
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mathAverageLabel: UILabel!
    @IBOutlet weak var readingAverageLabel: UILabel!
    @IBOutlet weak var writingAverageLabel: UILabel!
    
    weak var coordinator: MainCoordinator?
    var viewModel:NYCSchoolsResultsViewModel?
    var currentSchool:NYCSchools?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SAT RESULTS"
        viewModel?.schoolName.bind{ [weak self] name in
            self?.title = name

            self?.nameLabel.text = "School Name : \(name ?? "N/A")"
        }
        viewModel?.mathScore.bind{ [weak self] score in
            self?.mathAverageLabel.text = "Math Avg Score is : \(score ?? "N/A")"
        }
        viewModel?.readingScore.bind{ [weak self] score in
            self?.readingAverageLabel.text = "Reading Avg Score is : \(score ?? "N/A")"
        }
        viewModel?.writingScore.bind{ [weak self] score in
            self?.writingAverageLabel.text = "Writing Avg Score is : \(score ?? "N/A")"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let currentSchool = currentSchool,let id = currentSchool.id else { return }
        viewModel?.getCurrentSchoolResults(withSchoolName: currentSchool.schoolName, withSchoolID: id)
//        viewModel?.getCurrentSchoolResults(with withSchoolID: )
    }
}
