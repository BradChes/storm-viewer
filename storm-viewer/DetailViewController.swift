//
//  DetailViewController.swift
//  storm-viewer
//
//  Created by Bradley Chesworth on 27/01/2020.
//  Copyright © 2020 Brad Chesworth. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    var totalViews = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "\(selectedPictureNumber) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let defaults = UserDefaults.standard
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            totalViews = defaults.integer(forKey: imageToLoad)
            totalViews += 1
            defaults.set(totalViews, forKey: imageToLoad)
        } else {
            assertionFailure("No image to load.")
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
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImage else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
}
