//
//  TemplateManager.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

struct TemplateManager: TemplateManagerInterface {
    
    private let queue = DispatchQueue(label: "com.testTek.templateManager", qos: .userInitiated)
    
    private var apiService: APIServiceInterface
    
    private let jsonDecoder = JSONDecoder()
    
    private let archiver: TemplateArchiverInterface?
    
    var timeOutRequest: Int {
        get { self.apiService.requestTimeOut }
        set { self.apiService.requestTimeOut = newValue }
    }
    
    init(apiService: APIServiceInterface, archiver: TemplateArchiverInterface? = nil) {
        self.apiService = apiService
        self.archiver = archiver
    }
    
    private func getCachedTemplate(onCompletion: @escaping ([Template]?) -> Void) {
        guard let archiver = archiver else {
            onCompletion(nil)
            return
        }

        archiver.retriveTemplate { template in
            guard
                let template = template,
                    template.isEmpty == false else {
                onCompletion(nil)
                return
            }
            onCompletion(template)
        }
    }
    
    func getTemplates(onCompletion: @escaping (Result<[TemplateInterface], TemplateServiceError>) -> Void) {
        self.apiService.getTemplate { result in
            switch result {
            case .failure(let error):
                self.getCachedTemplate { cachedTemplates in
                    guard let cachedTemplates = cachedTemplates else {
                        onCompletion(.failure(.APIServiceError(error: error)))
                        return
                    }
                    onCompletion(.success(cachedTemplates))
                }

            case .success(let data):
                self.queue.async {
                    do {
                        let dico = try self.jsonDecoder.decode([String : [Template]].self, from: data)

                        guard let dest = dico["templates"] else {
                            
                            self.getCachedTemplate { cachedTemplate in
                                guard let cachedTemplate = cachedTemplate else {
                                    onCompletion(.failure(.noData))
                                    return
                                }
                                onCompletion(.success(cachedTemplate))
                            }
                            return
                        }
                        self.archiver?.save(template: dest, onCompletion: nil)
                        onCompletion(.success(dest))
                    } catch {
                        self.queue.async {
                            
                            self.getCachedTemplate { cachedTemplates in
                                guard let cachedTemplates = cachedTemplates else {
                                    onCompletion(.failure(.SerialisationError(error: error)))
                                    return
                                }
                                onCompletion(.success(cachedTemplates))
                            }
                        }
                    }
                }
            }
        }
    
//        guard let jsonURL = Bundle.main.url(forResource: "templates", withExtension: "json") else { return }
//
//        let data = try! Data(contentsOf: jsonURL)
//        let dico = try! self.jsonDecoder.decode([String : [Template]].self, from: data)
//        onCompletion(.success(dico["templates"]!))
    }
    
}

protocol TemplateManagerInterface {
    func getTemplates(onCompletion: @escaping (Result<[TemplateInterface], TemplateServiceError>) -> Void)
    var timeOutRequest: Int { get set }
}

enum TemplateServiceError: Error {
    case APIServiceError(error: APIServiceError)
    case SerialisationError(error: Error)
    case noData
    
    var userReadableText: String {
        switch self {
        case .noData:
            return "There is no data from the server"
        case .SerialisationError:
            return "Serialization error"
        case .APIServiceError(error: let error):
            switch error {
            case .httpError(let code, _):
                return "API error, http code: \(code)"
            case .noInternet:
                return "Internet is not reachable"
            case .noData(_):
                return "There is no data from the server"
            case .noHttpResponse:
               return "There is no data from the server"
            }
        }
    }
}

