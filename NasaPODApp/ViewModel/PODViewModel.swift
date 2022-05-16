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
    private let coreDataRepository = NasaPODDataRepository()
    private let apiRepository = NasaPODAPIRepository()

    private func fetchCachedPODData() {
        coreDataRepository.fetchPODDetails { data in
            if let podData = data {
                self.podData = podData
                self.isLoading = false
                self.coreDataRepository.fetchPODImage(imageUrl: "") { image in
                    if let podImage = image {
                        self.podImage = podImage
                    }
                }
            }
        }
    }

    func fetchPODData() {
        apiRepository.fetchPODDetails { data in
            if let podData = data {
                self.podData = podData
                self.fetchPODImage(url: podData.url)
            } else {
                self.fetchCachedPODData()
            }
        }
    }

    func fetchPODImage(url: String) {
        apiRepository.fetchPODImage(imageUrl: url) { image in
            if let podImage = image {
                self.podImage = podImage
                self.isLoading = false
                if let podData = self.podData {
                    self.coreDataRepository.saveNasaPODData(podData: podData,
                                                            image: podImage)
                }
            } else {
                self.fetchCachedPODData()
            }
        }
    }
}
