//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Kristiyan Kornazov on 6.09.21.
//

import XCTest

@testable import BreakingBad

class BreakingBadTests: XCTestCase {
    
    var sut: CharactersViewModel!
    var request: CharactersRequest!
    
    override func setUp() {
        super.setUp()
        request = CharactersRequest()
        sut = CharactersViewModel()
    }
    
    override func tearDown() {
        sut = nil
        request = nil
        super.tearDown()
    }

    func testAll() {
        
        testFilteringCharacters(by: "w")
        testFilteringCharacters(by: "a")
        testFilteringCharacters(by: "k")
        testFilteringCharacters(by: "n")
        
        testFilteringCharactersBySeason(by: 1)
        testFilteringCharactersBySeason(by: 2)
        testFilteringCharactersBySeason(by: 3)
        testFilteringCharactersBySeason(by: 4)
        testFilteringCharactersBySeason(by: 5)
    }
    
    func testNetworkConfig() {
        let pathURL = NetworkConfig.baseURL
        
        XCTAssertEqual(pathURL, "https://breakingbadapi.com/api/")
        XCTAssertNotEqual(pathURL, "google.com")
        
    }
    
    func testCharacterRequest() {
        let method = request.method.rawValue
        
        XCTAssertEqual(method, "GET")
        XCTAssertNil(request.bodyParameters)
        XCTAssertNil(request.httpBody)
        XCTAssertNil(request.httpHeaders)
        XCTAssertEqual(request.urlParameters, [])
    }
    func testBeforeCallingTheAPI() {
        XCTAssertNil(sut.characters)
    }
    
    func testFilteredCharacterIsNil() {
        XCTAssertNil(sut.filterCharacters)
    }
    
    func testFetchCharacters() throws {
        
        let completedExpectation = expectation(description: "Completed")

        sut.loadDataTest { _ in
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(sut.characters)
    }
    
    func testFilteringCharacters() {
        let completedExpectation = expectation(description: "Completed")

        sut.loadDataTest { _ in
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        sut.numberForSeason = nil
        sut.searchString = "mike"
        
        let filterData = sut.characters?.filter( {$0.name!.lowercased().contains("mike") })
        
        XCTAssertEqual(sut.filterCharacters!.count, filterData!.count)
        
        for index in 0..<sut.filterCharacters!.count {
            let character = sut.filterCharacters![index]
            let secondCharacter = filterData![index]
            XCTAssertEqual(character.charID!, secondCharacter.charID!)
        }
        
    }
    
    func testFilteringCharacters(by word: String) {
        let completedExpectation = expectation(description: "Completed")

        sut.loadDataTest { _ in
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        sut.searchString = word
        
        let filterData = sut.characters?.filter( {$0.name!.lowercased().contains(word)})
        
        XCTAssertEqual(sut.filterCharacters?.count, filterData?.count)
        
        for index in 0..<sut.filterCharacters!.count {
            let character = sut.filterCharacters![index]
            let secondCharacter = filterData![index]
            XCTAssertEqual(character.charID!, secondCharacter.charID!)
        }
    }
    
    func testFilteringCharactersBySeason(by season: Int) {
        let completedExpectation = expectation(description: "Completed")

        sut.loadDataTest { _ in
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        sut.searchString = nil
        sut.numberForSeason = season
        
        let filterData = sut.characters?.filter( {$0.appearance!.contains(season)})
        
        XCTAssertEqual(sut.filterCharacters?.count, filterData?.count)
        
        for index in 0..<sut.filterCharacters!.count {
            let character = sut.filterCharacters![index]
            let secondCharacter = filterData![index]
            XCTAssertEqual(character.charID!, secondCharacter.charID!)
        }
    }
    
    func testWhenNoFilterIsNeeded() {
        testFilteringCharactersBySeason(by: 3)
        testFilteringCharacters(by: "white")
        
        sut.searchString = nil
        sut.numberForSeason = nil
        
        for index in 0..<sut.characters!.count {
            let character = sut.filterCharacters![index]
            let secondCharacter = sut.filterCharacters![index]
            XCTAssertEqual(character.charID!, secondCharacter.charID!)
        }
    }
}
