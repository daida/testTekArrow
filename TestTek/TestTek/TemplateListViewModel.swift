//
//  TemplateListViewModel.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

class TemplateListViewModel {
    
    private let manager: TemplateManagerInterface
    
    init(templateManager: TemplateManagerInterface) {
        self.manager = templateManager
        
        self.manager.getTemplate { result in
            switch result {
            case .success(let template):
                print(template)
            case .failure(let error):
                print(error)
            }
        }
    }
}
