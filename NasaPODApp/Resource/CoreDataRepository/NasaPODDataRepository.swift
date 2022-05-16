//
//  NasaPODDataRepository.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import UIKit

class NasaPODDataRepository: NasaPODCoreDataRepository {
    private let container = PersistenceController.shared.container
    private let context = PersistenceController.shared.container.viewContext

    func saveNasaPODData(podData: NasaPODResponse, image: UIImage) {
        container.performBackgroundTask { privateContext in
            let cdPODData = PODData(context: privateContext)
            cdPODData.title = podData.title
            cdPODData.date = podData.date
            cdPODData.explanation = podData.explanation
            cdPODData.image = image.jpegData(compressionQuality: 1.0)

            if privateContext.hasChanges {
                try? privateContext.save()
            }
        }
    }

    func fetchPODDetails(completion: @escaping (NasaPODResponse?) -> Void) {
        do {
            let cdPODData: PODData? = try context.fetch(PODData.fetchRequest()).first
            if let title = cdPODData?.title,
               let date = cdPODData?.date,
               let explanation = cdPODData?.explanation {
                let podData = NasaPODResponse(title: title,
                                              date: date,
                                              explanation: explanation)
                completion(podData)
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
            debugPrint("Unable to fetch from persistance storage...")
        }
    }

    func fetchPODImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        do {
            let cdPODData: PODData? = try context.fetch(PODData.fetchRequest()).first
            if let image = cdPODData?.image {
                completion(UIImage(data: image))
            }
        } catch {
            completion(nil)
            debugPrint("Unable to fetch from core data...")
        }
    }
}
