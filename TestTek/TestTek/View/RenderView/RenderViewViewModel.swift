//
//  RenderViewViewModel.swift
//  TestTek
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation

class RenderViewViewModel: RenderViewViewModelInterface {

    let drawer: DrawerInterface.Type
    let template: TemplateInterface
    
    init(drawer: DrawerInterface.Type, template: TemplateInterface) {
        self.drawer = drawer
        self.template = template
    }
}

protocol RenderViewViewModelInterface {
    var drawer: DrawerInterface.Type { get }
    var template: TemplateInterface { get }
}
