//
//  TemplateViewModel.swift
//  TestTek
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation

class TemplateViewModel: TemplateViewModelInterface {
    
    let drawer: DrawerInterface.Type
    private let template: TemplateInterface
    let shouldDisplayName: Bool
    let name: String
    
    let id: UUID
    
    func generateCopyWith(shouldDisplayName: Bool) -> TemplateViewModelInterface {
        TemplateViewModel(drawer: drawer, template: template, shouldDisplayName: shouldDisplayName)
    }
    
    func generateRenderViewModel() -> RenderViewViewModelInterface {
        return RenderViewViewModel(drawer: drawer, template: template)
    }
    
    init(drawer: DrawerInterface.Type, template: TemplateInterface, shouldDisplayName: Bool) {
        self.drawer = drawer
        self.template = template
        self.shouldDisplayName = shouldDisplayName
        self.name = template.name
        self.id = UUID()
    }
    
}

protocol TemplateViewModelInterface {
    var drawer: DrawerInterface.Type { get }
    var shouldDisplayName: Bool { get }
    var name: String { get }
    
    var id: UUID { get }
    
    func generateRenderViewModel() -> RenderViewViewModelInterface
    func generateCopyWith(shouldDisplayName: Bool) -> TemplateViewModelInterface
}
