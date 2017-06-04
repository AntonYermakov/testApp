//
//  SignUpViewController.swift
//  testApp
//
//  Created by Yermakov Anton on 02.06.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var coPassword: UITextField!
    
    var reference : FIRDatabaseReference!
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

       reference = FIRDatabase.database().reference()
    }

    @IBAction func signUpBtn(_ sender: Any) {
        
        guard name.text != "", email.text != "", password.text != "", coPassword.text != "" else { return }
        if password.text == coPassword.text{
            
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
               
                if let error = error{
                    print(error.localizedDescription)
                }
                
                if let user = user{
                    
                    let date = Date()
                    let callendar = Calendar.current
                    
                    let day = callendar.component(.day, from: date)
                    let month = callendar.component(.month, from: date)
                    let year = callendar.component(.year, from: date)
                    let hour = callendar.component(.hour, from: date)
                    let minute = callendar.component(.minute, from: date)
                    
                    let time : String = "0\(day).0\(month).\(year) at \(hour):\(minute)"
                    
                    let userInfo = ["id" : user.uid, "full name" : self.name.text!, "email" : self.email.text!, "time" : time]
                    
                    self.reference.child("user").child(user.uid).setValue(userInfo)
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersVC")
                    self.present(vc, animated: true, completion: nil)
                }
            })
        }
        
        
       }

}
