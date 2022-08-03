//
//  TemplateView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import SwiftUI

struct TemplateView: View {
    
    let template: Template
    
    init(template: Template) {
        self.template = template
    }
    
    var body: some View {
        TemplateRenderViewBridge(data: template.data)
            .navigationTitle(self.template.name)
    }
}

struct TemplateView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let url = Bundle.main.url(forResource: "templates", withExtension: "json")!
        
        let Data = try! Data(contentsOf: url)
        
        let dico = try! JSONDecoder().decode([String : [Template]].self, from: Data)
        
        let firstTemplate = dico["templates"]!.first!
        
        TemplateView(template: firstTemplate)
    }
}
