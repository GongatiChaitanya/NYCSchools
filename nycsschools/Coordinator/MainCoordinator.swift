//
//  MainCoordinator.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import UIKit

class MainCoordinator: Coordinator {
    /* Coordinator for the whole app  */
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let showResultsViewModel = NYCSchoolsResultsViewModel()
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        /* Starts showing the table view */
        let schoolTableViewController = NYCSchoolsListViewController.instantiate()
        schoolTableViewController.coordinator = self
        navigationController.pushViewController(schoolTableViewController, animated: true)
    }
    
    func showResults(withSelectedSchool school :NYCSchools){
        /* Shows the results view and also provided the view model */
        let showResultsViewController = NYCSchoolsResultsViewController.instantiate()
        showResultsViewController.coordinator = self
        showResultsViewController.viewModel = showResultsViewModel
        showResultsViewController.currentSchool = school
        navigationController.pushViewController(showResultsViewController, animated: true)
    }
}
