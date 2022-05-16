//
//  HTTPClient.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import Foundation

enum NetworkResult<D, E> {
    case success(_ data: D)
    case failure(_ error: E)
}

class HTTPClient {
    static let shared = HTTPClient()

    func getRequest(url: String,
                    completion: @escaping (NetworkResult<Data, Error>?) -> Void) {
        guard let requestURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if error == nil {
                if let resultData = data {
                    completion(.success(resultData))
                }
            } else {
                if let errorData = error {
                    completion(.failure(errorData))
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
