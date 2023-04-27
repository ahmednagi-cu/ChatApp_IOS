//
//  Extension.swift
//  ChatApp
//
//  Created by ahmed nagi on 24/04/2023.
//

import UIKit
import JGProgressHUD
import SDWebImage
extension  UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool){
        view.endEditing(true)
        if show {
            UIViewController.hud.show(in: view)
        }else {
            UIViewController.hud.dismiss()
        }
    }
    
    func showMessage(title: String, message:String, completion: (() -> Void)? = nil ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default,handler: { _ in
            completion?()
        }))
        
        present(alert, animated: true)
    }
    
    func getImage(withImageURL imageURL: URL, completion: @escaping(UIImage) -> Void) {
        SDWebImageManager.shared().loadImage(with: imageURL, options: .continueInBackground, progress: nil) { image, data, error, cashType, finised, url in
            if let error = error {
                self.showMessage(title: "Error", message: error.localizedDescription)
                return
            }
            guard let image = image else { return }
            completion(image)
        }
    }
    
}


