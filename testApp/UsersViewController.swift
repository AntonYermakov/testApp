//
//  UsersViewController.swift
//  testApp
//
//  Created by Yermakov Anton on 02.06.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var users = [Users]()
    var ref : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        fetchUsers()
    }
    
    
    func fetchUsers(){
        
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            let users = snapshot.value as! [String : AnyObject]
            self.users.removeAll()
            
            for (_, value) in users{
                if let uid = value["uid"] as? String, let fullName = value["full name"] as? String, let email = value["email"] as? String{
                    
                    let userToShow = Users()
                    
                    userToShow.uid = uid
                    userToShow.name = fullName
                    userToShow.email = email
                    
                    self.users.append(userToShow)
                    
                    
                }
            }
            self.myTableView.reloadData()
        })
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.fullName.text = users[indexPath.row].name
        cell.email.text = users[indexPath.row].email
        
        return cell
    }

 
}
