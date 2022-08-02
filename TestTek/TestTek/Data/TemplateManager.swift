//
//  TemplateManager.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

struct TemplateManager: TemplateManagerInterface {
   
    private var apiService: APIServiceInterface
    
    private let jsonDecoder = JSONDecoder()
    
    var timeOutRequest: Int {
        get { self.apiService.requestTimeOut }
        set { self.apiService.requestTimeOut = newValue }
    }
    
    init(apiService: APIServiceInterface) {
        self.apiService = apiService
    }
    
    func getTemplate(onCompletion: @escaping (Result<[Template], TemplateServiceError>) -> Void) {
        self.apiService.getTemplate { result in
            switch result {
            case .failure(let error): onCompletion(.failure(.APIServiceError(error: error)))
            case .success(let data):
                do {
                    let dico = try self.jsonDecoder.decode([String : [Template]].self, from: data)
                    
                    guard let dest = dico["templates"] else {
                        onCompletion(.failure(.noData))
                        return
                    }
                    
                    onCompletion(.success(dest))
                } catch {
                    onCompletion(.failure(.SerialisationError(error: error)))
                }
            }
        }
    }
    
}

protocol TemplateManagerInterface {
    func getTemplate(onCompletion: @escaping (Result<[Template], TemplateServiceError>) -> Void)
    var timeOutRequest: Int { get set }
}

enum TemplateServiceError: Error {
    case APIServiceError(error: APIServiceError)
    case SerialisationError(error: Error)
    case noData
}
