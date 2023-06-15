//
//  SchoolsTableViewController.swift
//  nycsschools
//
//  Created by Abhinav Jayanthy on 4/24/22.
//

import UIKit

class NYCSchoolsListViewController: UITableViewController,Storyboardable {
    /* Table view to show all the schools info given more time, we can add pull to refresh , have a core data backing this up and if the api had pagination, we can prefetch the items and not have them all be fetched at the same time */

    @IBOutlet weak var schoolSearchBar: UISearchBar!
    private let viewModel = SchoolsViewModel()
    private var schools:[NYCSchools] = []
    private let reuseIdentifier = "eachSchool"
    private let numberOfSections = 1
    weak var coordinator: MainCoordinator?
    private var searching = false
    private var searchSchool:[NYCSchools] = []{
        didSet{
            if searching && searchSchool.count == 0 {
                setEmptyMessage("No Results Found")
            }else{
                restore()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uiNib = UINib(nibName: String(describing: NYCSchoolsTableViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: reuseIdentifier)
        schoolSearchBar.delegate = self
        viewModel.schools.bind { [weak self] schools in
            self?.schools = schools
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.isLoading.bind { [weak self] result in
            DispatchQueue.main.async {
                if result {
                    self?.setEmptyMessage("Downloading")
                    self?.tableView.isUserInteractionEnabled = false
                    self?.schoolSearchBar.isUserInteractionEnabled = false
                }else{
                    self?.restore()
                    self?.tableView.isUserInteractionEnabled = true
                    self?.schoolSearchBar.isUserInteractionEnabled = true
                }
            }
            
        }
        
        viewModel.didError.bind { [weak self] result in
            DispatchQueue.main.async {
                if result {
                    self?.setEmptyMessage("Something went wrong!")
                    self?.tableView.isUserInteractionEnabled = false
                    self?.schoolSearchBar.isUserInteractionEnabled = false
                }else{
                    self?.restore()
                    self?.tableView.isUserInteractionEnabled = true
                    self?.schoolSearchBar.isUserInteractionEnabled = true
                }
            }
        }
        self.title = "NYC SCHOOLS"
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: .zero)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel
        self.tableView.separatorStyle = .none
    }
    
    func restore() {
        self.tableView.backgroundView = nil
        self.tableView.separatorStyle = .singleLine
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchSchool.count
        }
        return schools.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NYCSchoolsTableViewCell else { return UITableViewCell() }
        if searching {
            cell.configure(withSchool: searchSchool[indexPath.row])
        }else{
            cell.configure(withSchool: schools[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            coordinator?.showResults(withSelectedSchool: searchSchool[indexPath.row])
        }else{
            coordinator?.showResults(withSelectedSchool: schools[indexPath.row])
        }
    }
}

extension NYCSchoolsListViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        schoolSearchBar.showsCancelButton = true
        self.searchSchool = self.schools.filter({ school in
            guard let schoolName = school.schoolName else { return false }
            if(schoolName.lowercased().contains(searchText.lowercased())){
                    return true
                }else{
                    return false
                }
            })
            self.searching = true
            self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        schoolSearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        schoolSearchBar.showsCancelButton = false
        searching = false
        schoolSearchBar.text = ""
        tableView.reloadData()
        schoolSearchBar.resignFirstResponder()
    }
}
