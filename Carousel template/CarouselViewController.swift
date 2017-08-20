//
//  CarouselViewController.swift
//  Carousel template
//
//  Created by Christine Chang on 8/18/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    let columns: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }

    // MARK: - CarouselViewController: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndividualViewCell", for: indexPath) as! IndividualViewCell
        
        cell.greetingLabel.text = "Hello"
        
        return cell
    }
}

// MARK: - CarouselViewController: UICollectionViewDelegateFlowLayout

extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.frame.width / columns)
        let height = Int(collectionView.frame.height)
        return CGSize(width: width, height: height)
    }
}

