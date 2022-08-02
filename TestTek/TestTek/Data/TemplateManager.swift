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
    
    var timeOutRequest: Int {
        get { self.apiService.requestTimeOut }
        set { self.apiService.requestTimeOut = newValue }
    }
    
    init(apiService: APIServiceInterface) {
        self.apiService = apiService
    }
    
    func getTemplates(onCompletion: @escaping (Result<[Template], TemplateServiceError>) -> Void) {
        self.apiService.getTemplate { result in
            switch result {
            case .failure(let error): onCompletion(.failure(.APIServiceError(error: error)))
            case .success(let data):
                self.queue.async {
                    do {
                        let dico = try self.jsonDecoder.decode([String : [Template]].self, from: data)
                        
                        guard let dest = dico["templates"] else {
                            onCompletion(.failure(.noData))
                            return
                        }
                        onCompletion(.success(dest))
                    } catch {
                        self.queue.async {
                            onCompletion(.failure(.SerialisationError(error: error)))
                        }
                    }
                }
            }
        }
    }
    
}

protocol TemplateManagerInterface {
    func getTemplates(onCompletion: @escaping (Result<[Template], TemplateServiceError>) -> Void)
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
