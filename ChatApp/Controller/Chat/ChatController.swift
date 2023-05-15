//
//  ChatController.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit

class ChatController: UICollectionViewController {
    // MARK: - Properties
    var messages: [MessageModel] = []
    private lazy var customInput : CustomInputViewTyping = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let iv = CustomInputViewTyping(frame: frame)
            iv.delegate = self
        return iv
    }()
    private var currentUser: UserModel
    private var otherUser: UserModel
    
    // MARK: - LifeCycle
    init(otherUser: UserModel,currentUser: UserModel){
        self.currentUser = currentUser
        self.otherUser = otherUser
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Config_UI()
        FetchMessages()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.markReadAllMessage()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        markReadAllMessage()
    }
    // add input view in collection view when is collection appear
    
    override var inputAccessoryView: UIView? {
        get {return customInput }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }

    
    // MARK: - Helpers
    private func Config_UI(){
        title = otherUser.fullname
        collectionView.backgroundColor = .white
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = layout
    }
    private func FetchMessages(){
        MessageServices.shared.fetchMessages(otherUser: otherUser) { [self] message in
            messages = message
            collectionView.reloadData()
            print(String(describing: message))
        }
    }
    
    private func markReadAllMessage(){
        MessageServices.shared.markReadAllMessage(otherUser: otherUser)
    }

}
// MARK: - data sourece
extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell else {
            return UICollectionViewCell()
        }
       
        let message = messages[indexPath.row]
        cell.viewModel = MessageViewModel(message: message)
     //   cell.configure()
        return cell
    }
    
    
}
// MARK: - Delegate flow layout
extension ChatController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return .init(top: 15, left: 0, bottom: 15, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cell = ChatCell(frame: frame)
        let messages = messages[indexPath.row]
        cell.viewModel = MessageViewModel(message: messages)
        cell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000 )
        let estimateSize = cell.systemLayoutSizeFitting(targetSize)

        return .init(width: view.frame.width, height: estimateSize.height)


   }


}
// MARK: - CustomInputViewTypingDelegate 
extension ChatController: CustomInputViewTypingDelegate {

    func customInputViewTyping(_ view: CustomInputViewTyping, wantUploadMessage message: String, sendbtn: UIButton) {
        MessageServices.shared.fetchSingleRecentMsg(otherUser: otherUser) { [self] unReadCount in
            MessageServices.shared.uploadMessage(message: message, currentUser:currentUser, otherUser: otherUser, unReadeCount: unReadCount + 1) { _ in
                self.collectionView.reloadData()
                print(unReadCount)
            }
        }
        view.cleartextView()
  }

    
}
