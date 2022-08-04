//
//  APIMock.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation

struct APIMock: APIServiceInterface {
    
    let jsonDecoder = JSONDecoder()
    
    var fileToUse: String = "templates"
    
    init(fileToUse: String? = nil) {
        self.requestTimeOut = 2
        if let fileToUse = fileToUse {
            self.fileToUse = fileToUse
        }
    }
    
    func getTemplate(onCompletion: @escaping (Result<Data, APIServiceError>) -> Void) {
        guard let jsonURL = Bundle.main.url(forResource: self.fileToUse, withExtension: "json") else { return }
        
        guard let data = try? Data(contentsOf: jsonURL) else {
            onCompletion(.failure(.noData(originalError: nil)))
            return
        }
        
        onCompletion(.success(data))
    }
    
    var requestTimeOut: Int
}
