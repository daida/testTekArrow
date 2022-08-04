//
//  RenderViewViewModel.swift
//  TestTek
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation

class RenderViewViewModel: RenderViewViewModelInterface {

    let drawer: DrawerInterface.Type
    let data: TemplateDataInterface
    
    init(drawer: DrawerInterface.Type, data: TemplateDataInterface) {
        self.drawer = drawer
        self.data = data
    }
}

protocol RenderViewViewModelInterface {
    var drawer: DrawerInterface.Type { get }
    var data: TemplateDataInterface { get }
}
