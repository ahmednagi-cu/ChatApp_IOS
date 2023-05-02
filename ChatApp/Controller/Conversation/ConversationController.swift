//
//  ConversationController.swift
//  ChatApp
//
//  Created by ahmed nagi on 24/04/2023.
//

import UIKit
import Firebase
class ConversationController: UIViewController {
    // MARK: - Properties
    private let user: UserModel
    
    private var conversations: [MessageModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var conversationsDictionary = [String : MessageModel]()
    private let tableView = UITableView()
    // MARK: - LifeCycle
    
    init(user: UserModel){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         congiUI()
        Config_TableView()
        FetchConversations()
    }
   
    // MARK: - Helpers
    func congiUI(){
        title = user.fullname
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        let logoutBarBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        let newConversationBarBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didHandelNewChat))
        navigationItem.rightBarButtonItem = newConversationBarBtn
        navigationItem.leftBarButtonItem = logoutBarBtn
        Add_Views()
        Add_Constraints()
    }
    private func Add_Views(){
        view.addSubview(tableView)
    }
    private func Add_Constraints(){
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func Config_TableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
    }
    /// fetch conversation data
    private func FetchConversations(){
        MessageServices.shared.fetchRecentMessages { conversation in
            conversation.forEach { conversation in
                self.conversationsDictionary[conversation.chatPartnerID] = conversation
            }
            self.conversations = Array(self.conversationsDictionary.values)
           
        }
    }
    
    func openChat(otheUser: UserModel,currentUser: UserModel){
        let controller = ChatController(otherUser: otheUser, currentUser: currentUser)
        navigationController?.pushViewController(controller, animated: true)
    }
  // MARK: - Add Actions
    /// Logout
    @objc func didTapLogout(){
        do{
            try Auth.auth().signOut()
            dismiss(animated: true)
        }
        catch {
            showMessage(title: "Error", message: error.localizedDescription)
        }
       
    }
    /// got to new chate
    @objc func didHandelNewChat(){
        let controller = NewChatController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConversationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath) as? ConversationCell else {
            return   UITableViewCell()
        }
        
        let message = conversations[indexPath.row]
        cell.viewModel = MessageViewModel(message: message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        showLoader(true)
        UserServices.shared.fetchUser(uid: conversation.chatPartnerID) { [self] otherUser in
              showLoader(false)
              openChat(otheUser: otherUser, currentUser: user )
        }
    }
    
    
}


// MARK: - protocol Extension NewChatControllerDelegate
extension ConversationController: NewChatControllerDelegate {
    func controller(_ vc: NewChatController, wantChatWithUser otherUser: UserModel) {
        vc.dismiss(animated: true)
        openChat(otheUser: otherUser, currentUser: user)
        print(user.fullname)
        
    }
    
    
}
