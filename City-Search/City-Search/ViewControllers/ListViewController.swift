//
//  ViewController.swift
//  City-Search
//
//  Created by Mathew Thomas on 02/02/2021.
//

import UIKit

class ListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var cityData: [City] = []
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Backbase City Search"
        self.fetchAllCities()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        
        self.registerTableViewCells()
        self.setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - Searchbar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.fetchCitiesWitchPrefix(prefix: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.fetchCitiesWitchPrefix(prefix: searchText)
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search Cities"
        searchBar.tintColor = UIColor(named: "cursorColor")
        navigationItem.titleView = searchBar
    }
    
    // MARK: - TableView Delegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchResultCell {
            let city = cityData[indexPath.row]
            cell.cityNameLabel.text = city.name
            cell.countryCodeLabel.text = city.country
            cell.latLongLabel.text = "Lat: \(city.coord.lat)," + " Long: \(city.coord.lon)"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityData[indexPath.row]
        print(city.name)
        //TODO: Show MapView
    }
    
    private func registerTableViewCells() {
        let searchCell = UINib(nibName: "SearchResultCell", bundle: nil)
        self.tableView.register(searchCell, forCellReuseIdentifier: "SearchResultCell")
    }
    
    // MARK: - Data Fetch Functions
    private func fetchAllCities() {
        DataHandler().fetchAllCities { (result) in
            
            self.startIndicator()
            switch result {
            
            case .success(let cities):
                DispatchQueue.main.async {
                    self.cityData = cities
                    self.stopIndicator()
                    self.tableView.reloadData()
                }
                break
                
            case .failure(let error):
                    self.stopIndicator()
                    self.showErrorMessage(message: error.localizedDescription)
                break
            }
        }
    }
    
    private func fetchCitiesWitchPrefix(prefix: String) {
        let filtered = DataHandler.sharedInstance.fetchCitiesWithPrefix(prefix: prefix)
        cityData = filtered
        self.tableView.reloadData()
    }
}
