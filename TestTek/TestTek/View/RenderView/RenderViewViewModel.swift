//
//  RenderViewViewModel.swift
//  TestTek
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
import UIKit

class RenderViewViewModel: RenderViewViewModelInterface {

    let drawer: DrawerInterface.Type
    let template: TemplateInterface
    let shouldDisplayBackgroundColor: Bool
    
    init(drawer: DrawerInterface.Type,
         template: TemplateInterface,
         shouldDisplayBackgroundColor: Bool) {
        
        self.drawer = drawer
        self.template = template
        self.shouldDisplayBackgroundColor = shouldDisplayBackgroundColor
    }
}

protocol RenderViewViewModelInterface {
    var drawer: DrawerInterface.Type { get }
    var template: TemplateInterface { get }
    var shouldDisplayBackgroundColor: Bool { get }
}
