//
//  PhotosCollectionViewController.swift
//  PhotoFilter
//
//  Created by Paweł Brzozowski on 22/01/2022.
//

import Foundation
import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePhotos()
    }
    
    private func populatePhotos() {
        // Request for user permission
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if status == .authorized {
                // Access to the photo lib
            }
        }
    }
}
