import Vision
import CoreML

let model = try VNCoreMLModel(for: MyCoreMLGeneratedModelClass().model)
let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
let handler = VNImageRequestHandler(url: myImageURL)
handler.perform([request])

func myResultsMethod(request: VNRequest, error: Error?) {
    guard let results = request.results as? [VNClassificationObservation]
        else { fatalError("huh") }
    for classification in results {
        print(classification.identifier, // the scene label
              classification.confidence)
    }

}


// You Will see a lot of people try to do it this way. Don't do it! It's much slower
// both on the processing as well as the actual inference



//guard let pixelBuffer = pickedImage.resize(to: CGSize(width: 224, height: 224)).pixelBuffer() else {
//    fatalError()
//}
//guard let classifierOutput = try? classifier.prediction(image: pixelBuffer) else {
//    fatalError()
//}
//
//resultLabel.text = classifierOutput.classLabel
//
//// ...
//
//extension UIImage {
//    
//    func resize(to newSize: CGSize) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
//        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        return resizedImage
//    }
//    
//    func pixelBuffer() -> CVPixelBuffer? {
//        let width = self.size.width
//        let height = self.size.height
//        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
//                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
//        var pixelBuffer: CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                         Int(width),
//                                         Int(height),
//                                         kCVPixelFormatType_32ARGB,
//                                         attrs,
//                                         &pixelBuffer)
//        
//        guard let resultPixelBuffer = pixelBuffer, status == kCVReturnSuccess else {
//            return nil
//        }
//        
//        CVPixelBufferLockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//        let pixelData = CVPixelBufferGetBaseAddress(resultPixelBuffer)
//        
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//        guard let context = CGContext(data: pixelData,
//                                      width: Int(width),
//                                      height: Int(height),
//                                      bitsPerComponent: 8,
//                                      bytesPerRow: CVPixelBufferGetBytesPerRow(resultPixelBuffer),
//                                      space: rgbColorSpace,
//                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
//                                        return nil
//        }
//        
//        context.translateBy(x: 0, y: height)
//        context.scaleBy(x: 1.0, y: -1.0)
//        
//        UIGraphicsPushContext(context)
//        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//        UIGraphicsPopContext()
//        CVPixelBufferUnlockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//        
//        return resultPixelBuffer
//    }
//}
