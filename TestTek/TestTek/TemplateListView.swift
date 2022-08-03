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
            if viewModel.shouldDisplayLoaderView == true {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let message = viewModel.errorMessageText {
                Button(message) {
                    self.startLoading()
                }
            } else {
                self.generateListView()
            }
        }.navigationTitle("Choose a template")
            .alert(isPresented: $viewModel.shouldDisplayAlertView) {
                Alert(title: Text(self.viewModel.errorMessageText ?? ""),
                      message: Text("Retry?"),
                      primaryButton: .default(Text("Retry"),
                                              action: self.startLoading), secondaryButton: .cancel())
            }
    }
    
    func generateListView() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(self.viewModel.templates) { template in
                    NavigationLink {
                        TemplateView(template: template, shouldDisplayTitle: true)
                    } label: {
                        TemplateView(template: template, shouldDisplayTitle: false)
                            .frame(height: 200)
                    }
                }
            }.padding()
        }.onAppear() {
            self.viewModel.startLoadingTemplate()
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
