//
//  NewChatController.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit


class NewChatController: UIViewController {
    // MARK: - Properteis
    private let tableView = UITableView()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Config_UI()
        Config_TableView()
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
}

extension NewChatController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return   UITableViewCell()
        }
        return cell
    }
    
    
}
