//
//  DetailViewController.swift
//  Project1CollectionView
//
//  Created by Justin Bengtson on 8/28/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailImageView: UIImageView!    
    var selectedImage: String?
    var totalImages: Int?
    var selectedImageNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picutre \(selectedImageNumber ?? 0) of \(totalImages ?? 0)"
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            detailImageView.image = UIImage(named: imageToLoad)
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
