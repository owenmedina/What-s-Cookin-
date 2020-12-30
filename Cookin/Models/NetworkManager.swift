//
//  NetworkManager.swift
//  Cookin
//
//  Created by Owen Medina on 12/29/20.
//

import Foundation
import UIKit

protocol NetworkManagerImageDelegate {
    func didGetImage(_ manager: NetworkManager, image: UIImage?)
    func didFailToGetImage(withError error: Error)
}

struct NetworkManager {
    var imageDelegate: NetworkManagerImageDelegate?
    func getImageFromURL(_ url: URL) {
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                imageDelegate?.didFailToGetImage(withError: error!)
                return
            }
            
            guard let imageData = data else {
                imageDelegate?.didFailToGetImage(withError: NetworkError(K.Network.Error.imageDataWassNil))
                return
            }
            
            let image = UIImage(data: imageData)
            imageDelegate?.didGetImage(self, image: image)
            print("Did getImageFromURL")
        }
        
        task.resume()
    }
    
    func getImageFromURLString(_ urlString: String) {
        print("In getImageFromURLString()")
        guard let url = URL(string: urlString) else {
            imageDelegate?.didFailToGetImage(withError: NetworkError(K.Network.Error.couldNotCreateURLFromString))
            return
        }
        
        getImageFromURL(url)
    }
}

class NetworkError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}
