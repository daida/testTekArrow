//
//  APIMock.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
@testable import TestTek

struct APIMock: APIServiceInterface {
    
    let jsonDecoder = JSONDecoder()
    
    var fileToUse: String = "templates"
    
    init() {
        self.requestTimeOut = 2
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
