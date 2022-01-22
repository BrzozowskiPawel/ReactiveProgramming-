//
//  FilterService.swift
//  PhotoFilter
//
//  Created by Paweł Brzozowski on 22/01/2022.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FilterService {
    
    private var context: CIContext
    
    init() {
        self.context =  CIContext()
    }
    
    // The same function as below but using RxSwift
    func applyFilterObserver(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage  in
                observer.onNext(filteredImage)
            }
            
            return Disposables.create()
        }
    }
    
    // InputImage -> image wich filter is aplied.
    // Completion -> what happen after applying
    // Using completion handler
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        // Create a filter
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        // Create a CoreImage
        if let sourceImage = CIImage(image: inputImage) {
            
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                // Create final img
                let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                // Send final image
                completion(processedImage)
            }
        }
    }
}
