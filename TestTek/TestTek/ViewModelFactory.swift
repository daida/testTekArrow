//
//  ViewModelFactory.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

struct ViewModelFactory {
    
    private static let appDrawer = Drawer.self
    private static let apiService = APIService()
    private let templateManager: TemplateManager
    
    static func generateListViewModel() -> TemplateListViewModel {
        return TemplateListViewModel(templateManager: TemplateManager(apiService: ViewModelFactory.apiService))
    }
    
    static func generateTemplateViewViewModel(template: TemplateInterface, shouldDisplayName: Bool) -> TemplateViewModelInterface {
        let template = template
        return TemplateViewModel(drawer: ViewModelFactory.appDrawer, template: template, shouldDisplayName: shouldDisplayName)
    }
}
