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
            Text(self.viewModel.templates.first?.name ?? "nothing")
            ForEach(self.viewModel.templates) { template in
                VStack {
                    Text(template.name)
                }
            }.onAppear() {
                self.startLoading()
            }
        }
    
    func startLoading() {
        self.viewModel.startLoadingTemplate()
    }
}

struct TemplateListView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateListView()
    }
}
