//
//  APIServiceInterface.swift
//  TestTek
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation

protocol APIServiceInterface {
    func getTemplate(onCompletion: @escaping (Result<Data, APIServiceError>) -> Void)
    var requestTimeOut: Int { get set }
}
