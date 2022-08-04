//
//  TemplateListViewModel.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

class TemplateListViewModel: ObservableObject {
    
    private let manager: TemplateManagerInterface
    
    private var mode: Mode = .loading {
        didSet { self.didUpdateMode() }
    }
    
    @Published var shouldDisplayLoaderView: Bool = false
    @Published var templatesViewModels: [TemplateViewModelInterface] = []
    @Published var errorMessageText: String? = nil
    @Published var shouldDisplayAlertView = false
    
    func didUpdateMode() {
        DispatchQueue.main.async {
            switch self.mode {
            case .loading:
                self.shouldDisplayAlertView = false
                self.shouldDisplayLoaderView = true
                self.templatesViewModels = []
                self.errorMessageText = nil
            case .error(let templateError):
                self.shouldDisplayAlertView = true
                self.errorMessageText = templateError.userReadableText
                self.templatesViewModels = []
                self.shouldDisplayLoaderView = false
            case .ready(let templates):
                self.shouldDisplayAlertView = false
                self.templatesViewModels = templates
                    .compactMap { ViewModelFactory.generateTemplateViewViewModel(template: $0,
                                                                                 shouldDisplayName: false) }
                self.errorMessageText = nil
                self.shouldDisplayLoaderView = false
            }
        }
    }
    
    init(templateManager: TemplateManagerInterface) {
        self.manager = templateManager
        self.didUpdateMode()
    }
    
    func startLoadingTemplate() {
        self.manager.getTemplates { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let template):
                self.mode = .ready(template)
            case .failure(let error):
                self.mode = .error(error)
            }
        }
    }
}

private extension TemplateListViewModel {
    enum Mode {
        case loading
        case ready([TemplateInterface])
        case error(TemplateServiceError)
    }
}
