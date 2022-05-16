//
//  NasaPODAPIRepository.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import UIKit

class NasaPODAPIRepository: NasaPODAPIResourceRepository {
    struct APIConstants {
        static let podUrl = "https://api.nasa.gov/planetary/apod?api_key=PSGjqKkc2MtgH7pskf4FHfgS5JSxsyFGnnPYhmTZ"
    }

    func fetchPODDetails(completion: @escaping (NasaPODResponse?) -> Void) {
        HTTPClient.shared.getRequest(url: APIConstants.podUrl) { result in
            if case .success(let data) = result {
                do {
                    let podResponse = try JSONDecoder().decode(NasaPODResponse.self,
                                                               from: data)
                    completion(podResponse)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }

    func fetchPODImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        HTTPClient.shared.getRequest(url: imageUrl) { result in
            if case .success(let data) = result {
                let image = UIImage(data: data)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }

}
