//
//  PODViewModel.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import Combine
import UIKit

class PODViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var podData: NasaPODResponse? = nil
    @Published var podImage: UIImage? = nil
    private let service = NasaPODService()

    func fetchPODData() {
        service.fetchPODDetails { data in
            if let podData = data {
                self.podData = podData
                self.fetchPODImage(url: podData.url)
            }
        }
    }

    func fetchPODImage(url: String) {
        service.fetchPODImage(imageUrl: url) { image in
            if let podImage = image {
                self.podImage = podImage
                self.isLoading = false
            }
        }
    }
}
