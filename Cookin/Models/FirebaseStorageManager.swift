//
//  FirebaseStorageManager.swift
//  Cookin
//
//  Created by Owen Medina on 12/29/20.
//

import Foundation
import FirebaseStorage

protocol FirebaseStorageManagerDelegate {
    func didStoreUserImage(_ manager: FirebaseStorageManager, imageURL: URL)
    func didFailToStoreUserImage(withError error: Error)
}

struct FirebaseStorageManager {
    private let storage = Storage.storage().reference()
    var delegate: FirebaseStorageManagerDelegate?
    
    func storeUserImage(_ imageData: Data, in path: String) {
        let imageReference = storage.child(path)
        
        imageReference.putData(imageData, metadata: nil) { (metadata, error) in
            guard error == nil else {
                delegate?.didFailToStoreUserImage(withError: error!)
                return
            }
            
            imageReference.downloadURL { (url, error) in
                guard error == nil else {
                    delegate?.didFailToStoreUserImage(withError: error!)
                    return
                }
                
                delegate?.didStoreUserImage(self, imageURL: url!.absoluteURL)
            }
        }
    }
}
