//
//  ChatController.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit

class ChatController: UICollectionViewController {
    // MARK: - Properties
     var masseges: [String] = [
     "hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you hi ahmed how are you",
     "this is simple data wher if you need",
     "hi ahmed how are you",
     "this is simple data wher if you need",
     "hi ahmed how are you this is simple data wher if you need hi ahmed how are you",
     "this is simple data wher if you need",
    ]
    private lazy var customInput : CustomInputViewTyping = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let iv = CustomInputViewTyping(frame: frame)
        
        return iv
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Config_UI()
    }
    // add input view in collection view
    override var inputAccessoryView: UIView? {
        get {return customInput }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }

    
    // MARK: - Helpers
    private func Config_UI(){
        collectionView.backgroundColor = .white
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = layout
        
        
    }

}
// MARK: - data sourece
extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return masseges.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell else {
            return UICollectionViewCell()
        }
       
        cell.config(text: masseges[indexPath.row])
        return cell
    }
    
    
}
// MARK: - Delegate flow layout
extension ChatController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cell = ChatCell(frame: frame)
        let text = masseges[indexPath.row]
        cell.config(text: text)
        cell.layoutIfNeeded()
        cell.setNeedsLayout()
        let height = cell.containerView.frame.height + cell.datLable.frame.height + 10
        let targetSize = CGSize(width: collectionView.frame.width, height: height )
        let estimateSize = cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return CGSize(width: view.frame.width, height: estimateSize.height)
       

    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.invalidateLayout()
    }

}

