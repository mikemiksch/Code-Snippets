//For use with an enum of filters, but handy for dealing with CIContext and returning a UIImage

import UIKit

enum FilterName : String {
    case vintage = "CIPhotoEffectTransfer"
    case blackAndWhite = "CIPhotoEffectMono"
    case sepia = "CISepiaTone"
    case comic = "CIComicEffect"
    case blur = "CIMotionBlur"
    case posterize = "CIColorPosterize"
    case invert = "CIColorInvert"
    case fade = "CIPhotoEffectFade"    
}

}

typealias FilterCompletion = (UIImage?) -> ()

class Filters {
    
    static let shared = Filters()
    
    static var originalImage = #imageLiteral(resourceName: "Robot Unicorn")
    
    static var history = [originalImage]
    
    static var ciContext: CIContext {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eaglContext = EAGLContext(api: .openGLES2)!
        return CIContext(eaglContext: eaglContext, options: options)
    }
    
    private init() {
        
    }
    
    class func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to create CIFilter") }
            
            let coreImage = CIImage(image: image)
            filter.setValue(coreImage, forKey: kCIInputImageKey)

            
            //Get final image using GPU
            
            guard let outputImage = filter.outputImage else { fatalError("Failed to get output image from filter") }
            
            if let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                
                let finalImage = UIImage(cgImage: cgImage)
                history.append(finalImage)
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
