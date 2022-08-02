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
        Text(template.name)
    }
}

//struct TemplateView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        TemplateView()
//    }
//}
