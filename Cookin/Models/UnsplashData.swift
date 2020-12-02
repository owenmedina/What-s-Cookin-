//
//  PhotoData.swift
//  Cookin
//
//  Created by Owen Medina on 12/1/20.
//

import Foundation

struct UnsplashData: Decodable {
    var results: [PhotoData]
}

struct PhotoData: Decodable {
    var urls: URLGrouper
}

struct URLGrouper: Decodable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}
