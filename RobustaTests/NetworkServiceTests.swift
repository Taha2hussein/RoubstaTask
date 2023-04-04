//
//  NetworkServiceTests.swift
//  RobustaTests
//
//  Created by A on 04/04/2023.
//

import XCTest
@testable import Robusta

class NetworkServiceTests: XCTestCase {

    var error: Error?
    var repos: [UserElement]?
    var sut: NetworkService!
    
    override func setUpWithError() throws {
        sut = NetworkService.shared
    }

    func testFetchRepos() {
        let exception = XCTestExpectation(description: "Repos Downloaded")
       
        self.sut.request(GithubRepoEndpoint.fetchGithubRepos) { (result: Result<[UserElement]>) in
            switch result {
            case.success(let data):
                self.repos = data
            case .failure(let error):
                self.error = error
            }
            exception.fulfill()
        }
        wait(for: [exception], timeout: 5)
        XCTAssertNil(self.error)
        XCTAssertNotNil(self.repos)
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    
}
