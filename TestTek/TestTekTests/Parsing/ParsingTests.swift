//
//  ParsingTests.swift
//  ParsingTests
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import XCTest
@testable import TestTek


class ParsingTests: XCTestCase {
    
    func dataIsOk(data: TemplateDataInterface, expectationDataModel: TemplateDataInterface) -> Bool {

        guard data.width == expectationDataModel.width else {
            XCTFail("Wrong data.width")
            return false
        }
        guard data.height == expectationDataModel.height else {
            XCTFail("Wrong data.height")
            return false
        }
        
        guard data.x == expectationDataModel.x else {
            XCTFail("Wrong data.x")
            return false
        }
        guard data.y == expectationDataModel.y else {
            XCTFail("Wrong data.y")
            return false
        }
        
        guard data.anchorX == expectationDataModel.anchorX else {
            XCTFail("Wrong data.anchorX")
            return false
        }
        guard data.anchorY == expectationDataModel.anchorY else {
            XCTFail("Wrong data.anchorY")
            return false
        }
        
        guard data.backgroundColor == expectationDataModel.backgroundColor else {
            XCTFail("Wrong data.backgroundColor")
            return false
        }
        
        guard data.padding == expectationDataModel.padding else {
            XCTFail("Wrong data.padding")
            return false
        }
        
        guard data.children.count == expectationDataModel.children.count else {
            XCTFail("Wrong children count")
            return false
        }
        
        return data.children
            .enumerated()
            .allSatisfy { self.dataIsOk(data: $1,
                                        expectationDataModel: expectationDataModel.children[$0])}
    }
    
    func modelIsOK(template: TemplateInterface, exepectationModel: ExpectationTemplate) -> Bool {
        guard template.name == exepectationModel.name else {
            XCTFail("Wrong name")
            return false
        }
        
        guard self.dataIsOk(data: template.data, expectationDataModel: exepectationModel.data) == true else {
            XCTFail("Wrong data parsing")
            return false
        }
      
        
        return true
    }
    
    func parsingIsOK(jsonFileName: String, expectedModel: [ExpectationTemplate]) {
        
        let mock = APIMock(fileToUse: jsonFileName)
        
        let templateManager = TemplateManager(apiService: mock)
        
        let expectation = XCTestExpectation(description: "Parsing data")
        
        templateManager.getTemplates { result in
            switch result {
            case .success(let templates):
                if templates.isEmpty == true {
                    XCTFail("Template Manager did fail to parse Data")
                }
                
                if templates.count != expectedModel.count {
                    XCTFail("is should be have the same amount of template than in the expectedModel")
                }
                
                if (templates.enumerated().allSatisfy { self.modelIsOK(template: $1,
                                                          exepectationModel: expectedModel[$0]) } ) {
                    expectation.fulfill()
                } else {
                    XCTFail("One or multiple templates was KO")
                }
                
                expectation.fulfill()
            case .failure:
                XCTFail("Template Manager did fail to parse Data")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testParsingRefJson() throws {
        self.parsingIsOK(jsonFileName: "templates",
                         expectedModel: ExpectationModelsFactory.generateRefModel())
     
    }
    
    func testAPIJson() throws {
        self.parsingIsOK(jsonFileName: "apiJSON",
                         expectedModel: ExpectationModelsFactory.generateAPIModels())
     
    }

}
