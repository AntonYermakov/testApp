//
//  UsersViewController.swift
//  testApp
//
//  Created by Yermakov Anton on 04.06.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var users  = [Users]()

    override func viewDidLoad() {
        super.viewDidLoad()

       fetchUsers()
    }
    
    
    func fetchUsers(){
        let ref = FIRDatabase.database().reference()
        
        
            ref.child("user").queryOrderedByKey().observe(.value, with: { (snapshot) in
             
                 let snap = snapshot.value as! [String : AnyObject]
                    self.users.removeAll()
                for(_, value) in snap{
                    let userToShow = Users()
                    if let fullName = value["full name"] as? String, let id = value["id"] as? String, let email = value["email"] as? String, let time = value["time"] as? String{
                        userToShow.email = email
                        userToShow.id = id
                        userToShow.name = fullName
                        userToShow.time = time
                        self.users.append(userToShow)
                    }
                }
                self.myTableView.reloadData()
            })
        
        ref.removeAllObservers()
    }
 
  

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
  
        cell.fullName.text = users[indexPath.row].name
        cell.time.text = users[indexPath.row].time
        
        return cell 
    }
    
    
 

}
