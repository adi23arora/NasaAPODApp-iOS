//
//  NasaPODResponse.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

class NasaPODResponse: Codable {
    let title, url, date, explanation: String
    let copyright, hdurl, mediaType, serviceVersion: String

    enum CodingKeys: String, CodingKey {
        case title, url, date, explanation
        case copyright, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }

    init(title: String,
         date: String,
         explanation: String,
         url: String = "",
         hdurl: String = "",
         copyright: String = "",
         mediaType: String = "",
         serviceVersion: String = "") {
        self.title = title
        self.date = date
        self.explanation = explanation
        self.url = url
        self.hdurl = hdurl
        self.copyright = copyright
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
    }
}
