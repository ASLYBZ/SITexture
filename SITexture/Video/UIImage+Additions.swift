//
//  UIImage+Additions.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/10.
//

import Foundation
import UIKit

extension UIImage {
    
    func makeCircularImage(size: CGSize) -> UIImage {
        // make a CGRect with the image's size
        let circleRect = CGRect.init(origin: .zero, size: size)
        
        // begin the image context since we're not in a drawRect:
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        
        // create a UIBezierPath circle
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width*0.5)
       
        // clip to the circle
        circle.addClip()
        
        // draw the image in the circleRect *AFTER* the context is clipped
        self.draw(in: circleRect)
        
        // create a border (for white background pictures)
      #if StrokeRoundedImages
        circle.lineWidth = 1
        UIColor.darkGray.set()
        circle.stroke()
      #endif
        
        // get an image from the image context
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext()
        
        return roundedImage ?? UIImage()
    }
}
