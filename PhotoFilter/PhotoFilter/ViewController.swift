//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Paweł Brzozowski on 22/01/2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var imageViewBG: UIImageView!
    
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
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] (photo) in
            self?.imageViewBG.image = photo
        }).disposed(by: disposeBag)
    }


}

