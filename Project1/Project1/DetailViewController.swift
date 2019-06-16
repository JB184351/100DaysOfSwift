//
//  DetailViewController.swift
//  Project1
//
//  Created by Justin Bengtson on 6/15/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        // Will disable the large titles off in the Detail View (When viewing the picture)
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    // Will make the navigation bar disappear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
