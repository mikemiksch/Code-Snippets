import UIKit

//For use with an enum of different CIFilters

enum FilterName : String {
    case vintage = "CIPhotoEffectTransfer"
    case blackAndWhite = "CIPhotoEffectMono"
    case sepia = "CISepiaTone"
    case comic = "CIComicEffect"
    case blur = "CIMotionBlur"
    
}

typealias FilterCompletion = (UIImage?) -> ()

class Filters {
    
    static var originalImage = #imageLiteral(resourceName: "")
    
    class func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to create CIFilter") }
            
            let coreImage = CIImage(image: image)
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            
            //GPU Context
            let options = [kCIContextWorkingColorSpace : NSNull()]
            guard let eaglContext = EAGLContext(api: .openGLES2) else { fatalError("Failed to create EAGLContext") }
            
            let ciContext = CIContext(eaglContext: eaglContext, options: options)
            
            //Get final image using GPU
            
            guard let outputImage = filter.outputImage else { fatalError("Failed to get output image from filter") }
            
            if let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                
                let finalImage = UIImage(cgImage: cgImage)
                history.append(finalImage)
                print(history)
                OperationQueue.main.addOperation {
                    completion(finalImage)
                }
                
            } else {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
            
        }
    }
    
}
