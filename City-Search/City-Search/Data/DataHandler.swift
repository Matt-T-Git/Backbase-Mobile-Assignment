//
//  DataHandler.swift
//  City-Search
//
//  Created by Mathew Thomas on 02/02/2021.
//

import Foundation

class DataHandler { //TODO: TESTS
    
    static let sharedInstance = DataHandler()
    var fullCityList : [City] = []
    
    // MARK: - Fetch All Cities From JSON File
    func fetchAllCities(completion: @escaping (Result<[City], Error>) -> Void){
        let path = Bundle.main.path(forResource: "cities", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            do {
                DataHandler.sharedInstance.fullCityList = try decoder.decode([City].self, from: data).sorted { $0.name < $1.name }
                DispatchQueue.main.async {
                    completion(.success(DataHandler.sharedInstance.fullCityList))
                }
            } catch {
                completion(.failure(error))
                print("Json decoder error: " + error.localizedDescription)
            }
        } catch {
            completion(.failure(LocalizedError.self as! Error))
            print(LocalizedError.self)
        }
    }
    
    // MARK: - Fetch Cities With Prefix String
    func fetchCitiesWithPrefix(prefix: String) -> [City] {
        guard fullCityList.count >= 0 else {
            fetchAllCities(completion: {_ in})
            return []
        }
        
        let filteredCities = DataHandler.sharedInstance.fullCityList.filter() { $0.name.lowercased().contains(prefix.lowercased()) }
        return filteredCities.sorted { $0.name < $1.name }
    }
}
