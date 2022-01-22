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
    // Array fo asstes
    private var images = [PHAsset]()
    
    // Inherite parent class functionality
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate with photos
        populatePhotos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell is not found")
        }
        
        // Get an asset
        let asset = self.images[indexPath.row]
        
        // Get a image form asset with help of manager
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 128, height: 128), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.cellImage.image = image
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    private func populatePhotos() {
        // Request for user permission
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            if status == .authorized {
                // Assets of photo lib
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                
                assets.enumerateObjects { object, count, stop in
                    self?.images.append(object)
                }
                
                // Most recent on the top
                self?.images.reverse()
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }
        }
    }
}
