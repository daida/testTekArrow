//
//  ViewModels.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import XCTest
import Combine

@testable import TestTek

class ViewModels: XCTestCase {
    
    func testTemplateViewModel() {
        let templateManager = TemplateManager(apiService: APIMock())
        
        let expectAPI = XCTestExpectation()
        
        templateManager.getTemplates { result in
            switch result {
            case .success(let templates):
                guard let first = templates.first else {
                    XCTFail("no Data")
                    return
                }
                let viewModel = TemplateViewModel(drawer: Drawer.self,
                                                  template: first,
                                                  shouldDisplayName: true)
                XCTAssertEqual(viewModel.name, "My first template")
                XCTAssertEqual(viewModel.shouldDisplayName, true)
                let falseViewModel = viewModel.generateCopyWith(shouldDisplayName: false)
                XCTAssertEqual(falseViewModel.name, "My first template")
                XCTAssertEqual(falseViewModel.shouldDisplayName, false)
                expectAPI.fulfill()
            case .failure(let error):
                print(error)
            }
        }
        wait(for: [expectAPI], timeout: 5)
    }
    
    func testListViewModel() {
        
        var cancellables: Set<AnyCancellable> = []
        
        let templateManager = TemplateManager(apiService: APIMock(fileToUse: "templates"))
        let viewModel = TemplateListViewModel(templateManager: templateManager)
        
        let loadingExp = XCTestExpectation()
        let dataExp = XCTestExpectation()
        let displayErrorViewExp = XCTestExpectation()
        let displayErrorMessage = XCTestExpectation()
        
      
        viewModel.$shouldDisplayLoaderView.sink { state in
            if state == true {
                loadingExp.fulfill()
            }
        } .store(in: &cancellables)
        
        viewModel.$templatesViewModels.sink { vms in
            if vms.isEmpty == false {
                dataExp.fulfill()
            }
        } .store(in: &cancellables)
        
        viewModel.startLoadingTemplate()
        
        let failTemplateManager = TemplateManager(apiService: APIMock(fileToUse: "ddsfljf"))
        let failViewModel = TemplateListViewModel(templateManager: failTemplateManager)
        
        failViewModel.$shouldDisplayAlertView.sink { alert in
            if alert == true {
                displayErrorViewExp.fulfill()
            }
        } .store(in: &cancellables)
        
        failViewModel.$errorMessageText.sink { message in
            if message != nil {
                displayErrorMessage.fulfill()
            }
        } .store(in: &cancellables)
        
        failViewModel.startLoadingTemplate()
        
        wait(for: [loadingExp, dataExp, displayErrorViewExp, displayErrorMessage], timeout: 5)
        
    }
  
}
