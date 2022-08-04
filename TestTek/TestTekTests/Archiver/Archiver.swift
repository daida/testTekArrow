//
//  Archiver.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import XCTest
@testable import TestTek

class Archiver: XCTestCase {
    
    func testArchive() {
        
        let expect = XCTestExpectation()
        
        let manager = TemplateManager(apiService: APIMock())
        let archiver = TemplateArchiver()
        
        manager.getTemplates { result in
            switch result {
            case .success(let templates):
                if let templates = templates as? [Template] {
                    archiver.save(template: templates) { sucess in
                        XCTAssertEqual(sucess, true)
                        archiver.retriveTemplate { cachedTemplates in
                            if cachedTemplates?.isEmpty == false {
                                expect.fulfill()
                            } else {
                                XCTFail("Archive Error")
                            }
                        }
                    }
                }
            case .failure:
                XCTFail("API ERROR")
                expect.fulfill()
            }
        }

        wait(for: [expect], timeout: 20)
    }

}

