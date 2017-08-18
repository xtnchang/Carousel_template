//
//  CarouselFlowLayout.swift
//  Carousel template
//
//  Created by Christine Chang on 8/18/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import UIKit

// Code adapted from Ray Wenderlich's tutorial on collection view layouts. https://videos.raywenderlich.com/courses/65-custom-collection-view-layout/lessons/3

class CarouselFlowLayout: UICollectionViewFlowLayout {

    // Set the default transparency and size of each collection view item.
    let standardItemAlpha: CGFloat = 0.5
    let standardItemScale: CGFloat = 0.5
    
    // Specify layout attributes for all cells in the collection view. Call the changeLayoutAttributes method.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // First, get the default attributes (in array form).
        let attributes = super.layoutAttributesForElements(in: rect)
        
        // Create an empty array to hold modified attributes.
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        // Iterate through the array of attributes.
        for itemAttribute in attributes! {
            
            // Make a copy of each attribute before modifying it to avoid memory issues.
            let itemAttributeCopy = itemAttribute.copy() as! UICollectionViewLayoutAttributes
            
            // Modify the attribute and add it to the attributesCopy array.
            changeLayoutAttributes(itemAttributeCopy)
            attributesCopy.append(itemAttributeCopy)
        }
        
        return attributesCopy
    }
    
    // Update the layout as the user scrolls.
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // Change the cell's size and transparency depending on its distance from the horizontal center of the collection view.
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        
        // Locate the horizontal center of the collection view.
        let collectionCenter = collectionView!.frame.size.width/2
        
        // For each pixel on a collection view item, the offset is the point that that pixel has been offset to after the last scroll motion.
        let offset = collectionView!.contentOffset.x
        
        // Shift the center by the value of offset, setting a new normalized center.
        let normalizedCenter = attributes.center.x - offset
        
        // Calculate the maximum distance a collection view item can move across the screen
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        
        // At a given point in time, determine how far a collection view item as moved as a result of the scroll. The maximum distance it could have moved is maxDistance. Otherwise, the distance it has moved is the delta of the original center and the normalized center (collectionCenter - normalizedCenter).
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        // Decide on a ratio used to calculate each collection view item's transparency and size in relation to its distance from the center. At the center, this equation is (1-0)/1 = 1.
        let ratio = (maxDistance - distance)/maxDistance
        
        // At the center, the transparency and size are at 100%, i.e. (1 * (1 - 0.5)) + 0.5. As the distance traveled by the collection view item increases, the ratio decreases, resulting in lower alpha values (hence more transparent).
        let alpha = ratio * (1 - self.standardItemAlpha) + self.standardItemAlpha
        let scale = ratio * (1 - self.standardItemScale) + self.standardItemScale
        
        // Set the item's transparency.
        attributes.alpha = alpha
        
        // Set the item's size by transforming it using the Core Animation scaling method.
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    }
}
