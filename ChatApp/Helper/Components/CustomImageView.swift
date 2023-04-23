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
        contentMode = .scaleAspectFit
        layer.cornerRadius = cornarRadius
        
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
