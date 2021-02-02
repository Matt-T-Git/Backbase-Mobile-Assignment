//
//  ViewController.swift
//  City-Search
//
//  Created by Mathew Thomas on 02/02/2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var cityData: [City] = []
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Backbase City Search"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        
        self.registerTableViewCells()
        self.setupSearchBar()
    }
    
    // MARK: - Searchbar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search Cities"
        searchBar.tintColor = UIColor(named: "cursorColor")
        navigationItem.titleView = searchBar
    }
    
    // MARK: - TableView Delegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    private func registerTableViewCells() {
        let searchCell = UINib(nibName: "SearchResultCell", bundle: nil)
        self.tableView.register(searchCell, forCellReuseIdentifier: "SearchResultCell")
    }

}
