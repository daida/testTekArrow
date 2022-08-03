//
//  TemplateView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import SwiftUI

struct TemplateView: View {
    
    let template: Template
    let shouldDisplayTitle: Bool
    
    init(template: Template, shouldDisplayTitle: Bool) {
        self.template = template
        self.shouldDisplayTitle = shouldDisplayTitle
    }
    
    var body: some View {
        if shouldDisplayTitle == true {
            TemplateRenderViewBridge(data: template.data)
                .navigationTitle(template.name)
        } else {
            TemplateRenderViewBridge(data: template.data)
        }

    }
}

struct TemplateView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let url = Bundle.main.url(forResource: "templates", withExtension: "json")!
        
        let Data = try! Data(contentsOf: url)
        
        let dico = try! JSONDecoder().decode([String : [Template]].self, from: Data)
        
        let firstTemplate = dico["templates"]!.first!
        
        TemplateView(template: firstTemplate, shouldDisplayTitle: false)
    }
}
