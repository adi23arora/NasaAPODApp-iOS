//
//  NasaPODRepository.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import UIKit

protocol NasaPODBaseRepository {
    func fetchPODDetails(completion: @escaping (NasaPODResponse?) -> Void)
    func fetchPODImage(imageUrl: String, completion: @escaping (UIImage?) -> Void)
}

protocol NasaPODAPIResourceRepository: NasaPODBaseRepository {
    //
}

protocol NasaPODCoreDataRepository: NasaPODBaseRepository {
    func saveNasaPODData(podData: NasaPODResponse, image: UIImage)
}

