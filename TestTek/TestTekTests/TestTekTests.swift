//
//  TestTekTests.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import XCTest
@testable import TestTek

class TestTekTests: XCTestCase {

    func testParsing() throws {
        let mock = APIMock()
        
        let templateManager = TemplateManager(apiService: mock)
        
        let expectation = XCTestExpectation(description: "Paring data")
        
        templateManager.getTemplates { result in
            switch result {
            case .success(let templates):
                if templates.isEmpty == true {
                    XCTFail("Template Manager did fail to parse Data")
                }
                expectation.fulfill()
            case .failure:
                XCTFail("Template Manager did fail to parse Data")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }    

}
