//
//  TemplateView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import SwiftUI

struct TemplateView: View {
    
    private let viewModel: TemplateViewModelInterface
    
    init(viewModel: TemplateViewModelInterface) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if self.viewModel.shouldDisplayName == true {
            TemplateRenderViewBridge(viewModel: self.viewModel.generateRenderViewModel())
                .navigationTitle(self.viewModel.name)
        } else {
            TemplateRenderViewBridge(viewModel: self.viewModel.generateRenderViewModel())
        }
    }
}

struct TemplateView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let url = Bundle.main.url(forResource: "templates", withExtension: "json")!
        
        let Data = try! Data(contentsOf: url)
        
        let dico = try! JSONDecoder().decode([String : [Template]].self, from: Data)
        
        let firstTemplate = dico["templates"]!.first!
        
        let viewModel = TemplateViewModel(drawer: Drawer.self, template: firstTemplate, shouldDisplayName: false)
        
        TemplateView(viewModel: viewModel)
    }
}
