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
            if viewModel.templatesViewModels.isEmpty == false {
                self.generateListView()
            }
            else if viewModel.shouldDisplayLoaderView == true {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let message = viewModel.errorMessageText {
                Button(message) {
                    self.startLoading()
                }
            }
        }.onAppear() {
            self.viewModel.startLoadingTemplate()
        }
        .navigationTitle("Choose a template")
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
                ForEach(self.viewModel.templatesViewModels, id: \.id) { templateViewModel in
                    NavigationLink {
                        TemplateView(viewModel: templateViewModel.generateCopyWith(shouldDisplayName: true))
                    } label: {
                        TemplateView(viewModel: templateViewModel)
                            .frame(height: 200)
                    }
                }
            }.padding()
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
