//
//  Ex+String.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 11..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension String{
    
    // for UITextField maxLenth
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) { return self }
        return String( Array(self).prefix(upTo: n) )
    }
    
    /*
     * 바코드 생성
     */
    func toGenerateBarCodeImage(view: UIView) -> UIImage? {
        return toGenerateBarCodeImage(size: view.bounds.size)
    }
    
    func toGenerateBarCodeImage(size: CGSize) -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator")
        {
            filter.setValue(data, forKey: "inputMessage")
            
            if let outputImage = filter.outputImage
            {
                let scaleX = size.width / outputImage.extent.size.width
                let scaleY = size.height / outputImage.extent.size.height
                let resultImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
                return UIImage(ciImage: resultImage)
            }
        }
        return nil
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func toDate(dateFormatter:DateFormatter) -> Date?{
        guard let stringDate = dateFormatter.date(from: self) else{
            return nil
        }
        return stringDate
    }
 
}
