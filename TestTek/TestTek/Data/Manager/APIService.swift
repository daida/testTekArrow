//
//  APIService.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation
import SwiftUI
import Reachability

struct APIService: APIServiceInterface {
    
    var requestTimeOut = 3
    
    private let reachability: Reachability? =  {
        let dest = try? Reachability()
        try? dest?.startNotifier()
        return dest
    }()
    
    private struct Constant{
        static let endPointURL = "https://ptitchevreuil.github.io/mojo/templates.json"
    }
    
    private var endPointURL: URL {
        guard let dest = URL(string: Constant.endPointURL) else {
            fatalError("Wrong end point URL, please edit endPointURL constant")
        }
        return dest
    }
    
    private var connectionIsAvailable: Bool {
        // If reachability as failed to initialize we assume the connection is ok
        // if it's not, a timeout will occur
        guard let reach = self.reachability else { return true }
        return reach.connection != .unavailable
    }
    
    
    func getTemplate(onCompletion: @escaping (Result<Data, APIServiceError>) -> Void) {
        
        // There is no Internet ! Thanks to Reachability
        // so we could send an error right away
        guard self.connectionIsAvailable == true else {
            onCompletion(.failure(.noInternet))
            return
        }
        
        // In order to be sure to request the last version of the file
        // the local and server cache is ignore
        let request = URLRequest(url: endPointURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TimeInterval(self.requestTimeOut))
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // No HTTP Response
            guard let response = response as? HTTPURLResponse else {
                onCompletion(.failure(.noHttpResponse))
                return
            }
            
            // Http Status code is not 200 (mean OK)
            guard response.statusCode == 200 else {
                onCompletion(.failure(.httpError(code: response.statusCode, originalError: error)))
                return
            }
            
            // There is no data in the response body
            guard let data = data else {
                onCompletion(.failure(.noData(originalError: error)))
                return
            }
            
            // Everything is alright :)
            onCompletion(.success(data))
        }.resume()
    }
    
}

enum APIServiceError: Error {
    case httpError(code: Int, originalError: Error?)
    case noInternet
    case noData(originalError: Error?)
    case noHttpResponse
}
