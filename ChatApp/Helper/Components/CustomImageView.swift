//
//  CustomImageView.swift
//  ChatApp
//
//  Created by ahmed nagi on 19/04/2023.
//


import UIKit
class CustomImageView: UIImageView {
    
    init(image: UIImage? = nil, width: CGFloat? = nil, height: CGFloat? = nil, cornarRadius: CGFloat = 0, backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleToFill
        layer.cornerRadius = cornarRadius
        clipsToBounds = true
        
        if let image = image {
            self.image = image
        }
        
        if let width = width {
            setWidth(width)
        }
        if let height = height {
            setWidth(height)
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
   
}


//MARK: UIImageExtension

extension UIImage {
    
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

}
