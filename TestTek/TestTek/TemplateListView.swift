//
//  TemplateListView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import SwiftUI

struct TemplateListView: View {
    
    @StateObject var viewModel = ViewModelFactory.generateListViewModel()
    
    
    var body: some View {
        VStack {
            Text("TemplateCount \(self.viewModel.templates.count)")
        }.onAppear() {
            self.viewModel.startLoadingTemplate()
        }.navigationTitle("Choose a template")

    }
}

struct TemplateListView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateListView()
    }
}
