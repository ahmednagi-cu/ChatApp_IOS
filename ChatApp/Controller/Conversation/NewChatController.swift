//
//  NewChatController.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit
import Firebase

protocol NewChatControllerDelegate : AnyObject {
    func controller(_ vc : NewChatController, wantChatWithUser otherUser: UserModel)
}

class NewChatController: UIViewController {
    // MARK: - Properteis
    public weak var delegate: NewChatControllerDelegate?
    var user :[UserModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
 
    
  
    private let tableView = UITableView()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Config_UI()
        Config_TableView()
        fetch_Users()
    }
    // MARK: - Helpers
    func Config_UI(){
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        title = "Search"
        Add_Views()
    }
    private func Add_Views(){
        view.addSubview(tableView)
        Add_Constraints()
    }
    private func Add_Constraints(){
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func Config_TableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
    }
    /// Fetch all user in firebase
    private func fetch_Users(){
        showLoader(true)
        UserServices.shared.fetchUsers { [weak self] user in
            self?.user = user
            guard let id = Auth.auth().currentUser?.uid else { return }
            guard let index = self?.user.firstIndex(where: {$0.uid == id}) else { return }
            self?.user.remove(at: index)
            self?.showLoader(false)
         
        }
    }
}

extension NewChatController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return   UITableViewCell()
        }
        
        let user = user[indexPath.row]
        cell.viewModel = NewConversationViewModel(user: user)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = user[indexPath.row]
        delegate?.controller(self, wantChatWithUser: user)
    }
    
    
}


