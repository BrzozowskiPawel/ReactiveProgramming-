//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Paweł Brzozowski on 22/01/2022.
//

import UIKit
import RxSwift
import AVFAudio

class ViewController: UIViewController {

    @IBOutlet weak var imageViewBG: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    // Create a disposeBag to avoid memory leaks as the subscription will not be disposed of correctly without
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Lager title
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else {
            fatalError("Segue destination not found")
        }
        
        // Subscribe to the observable publish subject
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] (photo) in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: disposeBag)
    }

    @IBAction func filterApplyPressed(_ sender: UIButton) {
        // Get the image from background
        guard let sourceImage = self.imageViewBG.image else {
            return
        }
        
//        // Using copletion handler
//        FilterService().applyFilter(to: sourceImage) { filteredImage in
//            DispatchQueue.main.async {
//                self.imageViewBG.image = filteredImage
//            }
//        }
        
        FilterService().applyFilterObserver(to: sourceImage).subscribe(onNext: { filteredImage in
            DispatchQueue.main.async {
                self.imageViewBG.image = filteredImage
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        // Update backround by setting imageView image to selected image
        self.imageViewBG.image = image
        // Show button
        self.filterButton.isHidden = false
    }

}

