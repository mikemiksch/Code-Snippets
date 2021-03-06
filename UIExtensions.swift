//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/23/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

extension UIImage {
    
    typealias ImageCallback = (UIImage?)->()
    
    class func fetchImageWith(_ urlString : String, callback: @escaping ImageCallback) {
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { callback(nil); return }
            
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)                
                OperationQueue.main.addOperation {
                    callback(image)
                }
            }
        }
    }
    
}

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}

extension UIImage {
    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    var path: URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {fatalError("Error getting documents directory")
    }
        
        return documentsDirectory.appendingPathComponent("image")
    }
}
