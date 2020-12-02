//
//  UnsplashManager.swift
//  Cookin
//
//  Created by Owen Medina on 12/1/20.
//

import Foundation
import UIKit

protocol UnsplashManagerDelegate {
    func didFailFetchingPhoto(withError error: Error)
    func didFindPhoto(_ manager: UnsplashManager, photo: Photo)
}

struct UnsplashManager {
    var delegate: UnsplashManagerDelegate?
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: K.API.Unsplash.Plist.fileName, ofType: "plist") else {
            fatalError("Invalid file path for file \(K.API.Unsplash.Plist.fileName).plist")
        }
        let unsplashPlist = NSDictionary(contentsOfFile: filePath)
        guard let value = unsplashPlist?.object(forKey: K.API.Unsplash.Plist.apiKey) as? String else {
            fatalError("Couldn't find key \(K.API.Unsplash.Plist.apiKey) in \(K.API.Unsplash.Plist.fileName).plist.")
        }
        return value
      }
    }
    
//    func performRequest(withURLString urlString: String) {
//        let urlString = "\(K.API.Unsplash.searchPhotoByKeywordEndpoint)\(K.API.Unsplash.keywordParameter)=\(keyword)&\(K.API.Unsplash.numberOfPagesParameter)=\(numberOfPages)&\(K.API.Unsplash.numberOfPhotosPerPageParameter)=\(photosPerPage)&\(K.API.Unsplash.orientationParameter)=\(orientation.rawValue)&\(K.API.Unsplash.apiKeyParameter)=\(apiKey)"
//        
//        guard let url = URL(string: urlString) else {
//            delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotCreateURLForPhotoSearch))
//            return
//        }
//        
//        let session = URLSession(configuration: .default)
//        
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                delegate?.didFailFetchingPhoto(withError: error!)
//                return
//            }
//            
//            guard let data = data else {
//                delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotAccessData))
//                return
//            }
//            
//            if let photo = parseToPhoto(data) {
//                return
//            }
////            // Print raw data (testing)
////            let dataString = String(data: data, encoding: .utf8) // utf-8 is just standard for encoding text in websites
////            print("data: \(dataString)")
//        }
//        
//        task.resume()
//    }
    
    func findImage(for keyword: String, numberOfPages: Int = 1, photosPerPage: Int = 1, orientation: Orientation = .squarish) {
        let keywords = "\(keyword) \(K.API.Unsplash.dishKeyword)"
        var urlString = "\(K.API.Unsplash.searchPhotoByKeywordEndpoint)\(K.API.Unsplash.keywordParameter)=\(keywords)&\(K.API.Unsplash.numberOfPagesParameter)=\(numberOfPages)&\(K.API.Unsplash.numberOfPhotosPerPageParameter)=\(photosPerPage)&\(K.API.Unsplash.orientationParameter)=\(orientation.rawValue)&\(K.API.Unsplash.apiKeyParameter)=\(apiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        guard let url = URL(string: urlString) else {
            delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotCreateURLForPhotoSearch))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                delegate?.didFailFetchingPhoto(withError: error!)
                return
            }
            
            guard let data = data else {
                delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotAccessData))
                return
            }
            
            if let parsedPhoto = parseToPhoto(data) {
                let photo = Photo(keyword: keyword, photo: parsedPhoto)
                delegate?.didFindPhoto(self, photo: photo)
            }
//            // Print raw data (testing)
//            let dataString = String(data: data, encoding: .utf8) // utf-8 is just standard for encoding text in websites
//            print("data: \(dataString)")
        }
        
        task.resume()
    }
    
    private func parseToPhoto(_ data: Data) -> UIImage? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UnsplashData.self, from: data)
            if decodedData.results.count > 0 {
                let photoData = decodedData.results[0]
                guard let url = URL(string: photoData.urls.regular) else {
                    delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotCreateURLForCreatingImage))
                    return nil
                }
                
                guard let imageData = try? Data(contentsOf: url) else {
                    delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotGetDataFromImageURL))
                    return nil
                }
                
                guard let image = UIImage(data: imageData) else {
                    delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.couldNotCreateImageFromData))
                    return nil
                }
                
                return image
            }
            delegate?.didFailFetchingPhoto(withError: UnsplashError(K.API.Unsplash.Error.noResultsFound))
            return nil
        } catch {
            delegate?.didFailFetchingPhoto(withError: error)
            return nil
        }
    }
}

enum Orientation: String {
    case squarish
    case portrait
    case landscape
}

class UnsplashError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}
