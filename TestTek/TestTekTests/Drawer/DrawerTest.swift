//
//  DrawerTest.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import XCTest

@testable import TestTek

class DrawerTest: XCTestCase {

    func testFramWith(jsonName: String, refFrames: (frames: [String: [CGRect]],
                                                screenRect: CGRect)) throws {
        let api = APIMock(fileToUse: jsonName)
        let manager = TemplateManager(apiService: api, archiver: TemplateArchiver())
        
        let expectation = XCTestExpectation()
        
        manager.getTemplates { result in
            switch result {
            case .success(let templates):

                if templates.isEmpty == true {
                    XCTFail("No data")
                    expectation.fulfill()
                }

                let testedFrames = DrawTesterTool.computeFrame(templates: templates,
                                                     rect: refFrames.screenRect)
                
                DrawTesterTool.prettyPrint(frames: testedFrames)
                
                if testedFrames != refFrames.frames {
                    XCTFail("Wrong frames")
                    expectation.fulfill()
                } else {
                    expectation.fulfill()
                }
            case .failure(_):
                XCTFail("API Fail")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testRefJson() {
        do {
            try self.testFramWith(jsonName: "templates",
                                          refFrames: DrawerFrameExpectationFactory.refFrameForIphone13ProMax())
        } catch {
            XCTFail("testFrame fail")
        }
    }
    
    func testAPIJson() {
        do {
            try self.testFramWith(jsonName: "apiJSON", refFrames: DrawerFrameExpectationFactory.ApiFrameForIphone13ProMax())
        } catch {
            XCTFail("testFrame fail")
        }
    }

}
