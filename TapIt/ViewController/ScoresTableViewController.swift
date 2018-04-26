//
//  ScoresTableViewController.swift
//  TapIt
//
//  Created by James Neeley on 4/25/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ScoresTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissView))
        self.navigationItem.setLeftBarButton(backButton, animated: true)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundView = UIImageView(image: UIImage(named: "trophy"))
        tableView.isOpaque = true
        tableView.backgroundColor = .clear
    }

    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserController.shared.users.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScoreTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let username = UserController.shared.users[indexPath.row]
        cell.backgroundColor = .clear
        cell.isOpaque = true
        cell.textLabel?.text = username.username
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        cell.detailTextLabel?.text = String(username.score)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let userToDelete = UserController.shared.users[indexPath.row]
            UserController.shared.delete(user: userToDelete)
            //maybe need to reload tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
