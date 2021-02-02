//
//  City_SearchTests.swift
//  City-SearchTests
//
//  Created by Mathew Thomas on 02/02/2021.
//

import XCTest
@testable import City_Search

class City_SearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Test all cities load - Expected rsult 209,557
    func testAllCitiesLoaded() throws {
        let handler = DataHandler()

        // create expectation
        let exp = expectation(description: "Loading cities")
        handler.fetchAllCities { (result) in
            // done, mark expectation as being fulfilled
            exp.fulfill()
        }
        
        // wait some time for outstanding expectations
        waitForExpectations(timeout: 3)

        // expectation has been fulfilled, check result is correct
        XCTAssertEqual(DataHandler.sharedInstance.fullCityList.count, 209557, "We should have loaded exactly 209,557 cities!")
    }
    
    // MARK: - Test Valid Search Input
    func testValidSearchInput() throws {
        let handler = DataHandler()
        let exp = expectation(description: "Loading cities")
        handler.fetchAllCities { (result) in
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        // search for 'cardi' prefix
        let cities = handler.fetchCitiesWithPrefix(prefix: "Cardi")
        for city in cities {
            XCTAssertTrue(city.name.lowercased().contains("cardi"), "Returned cities should only contain 'Cardi'!")
        }
    }
    
    // MARK: - Test Invalid Search Input
    func testInvalidSearchInput() throws {
        let handler = DataHandler()
        let exp = expectation(description: "Loading cities")
        handler.fetchAllCities { (result) in
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        // search for '!' prefix
        let cities = handler.fetchCitiesWithPrefix(prefix: "!")
        XCTAssertTrue(cities.count == 0, "Returned cities count should be zero!")
    }
}
