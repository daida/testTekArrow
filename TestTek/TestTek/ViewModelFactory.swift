//
//  ViewModelFactory.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

struct ViewModelFactory {
    static func generateListViewModel() -> TemplateListViewModel {
        let apiService = APIService()
        let templateManager = TemplateManager(apiService: apiService)
        return TemplateListViewModel(templateManager: templateManager)
    }
}
