//
//  PODViewModel.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import Combine
import UIKit

class PODViewModel: ObservableObject {

    struct AlertMessageConstant {
        static let oldPODError = "We are not connected to the internet, showing you the last image we have."
        static let noPODFoundError = "We are not connected to internet, no older image found"
    }

    @Published var isLoading = true
    @Published var podData: NasaPODResponse? = nil
    @Published var podImage: UIImage? = nil
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    private let coreDataRepository = NasaPODDataRepository()
    private let apiRepository = NasaPODAPIRepository()

    private func fetchCachedPODData() {
        coreDataRepository.fetchPODDetails { data in
            if let podData = data {
                self.podData = podData
                if self.compareDateOfCachedData(date: podData.date) == false {
                    self.showAlert = true
                    self.alertMessage = AlertMessageConstant.oldPODError
                }
                self.isLoading = false
                self.coreDataRepository.fetchPODImage(imageUrl: "") { image in
                    if let podImage = image {
                        self.podImage = podImage
                    }
                }
            } else {
                self.showAlert = true
                self.alertMessage = AlertMessageConstant.noPODFoundError
                self.isLoading = false
            }
        }
    }

    private func compareDateOfCachedData(date: String) -> Bool {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dateFormatter.string(from: currentDate))
        print(date)
        if dateFormatter.string(from: currentDate) == date {
            return true
        }
        return false
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
