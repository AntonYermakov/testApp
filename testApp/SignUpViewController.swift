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
    
    var ref : FIRDatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       ref = FIRDatabase.database().reference()
    }

    @IBAction func signUpBtn(_ sender: Any) {
        
        guard name.text != "", email.text != "", password.text != "", coPassword.text != "" else { return }
        if password.text == coPassword.text{
            
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
               
                if let error = error{
                    print(error.localizedDescription)
                }
               
                if let user = user{
                    
                    let userInfo : [String : Any] = ["uid" : user.uid, "full name" : self.name.text!, "email" : self.email.text!]
                    
                    self.ref.child("users").child(user.uid).setValue(userInfo)
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC")
                    self.present(vc, animated: true, completion: nil)
                }
            })
            
        } else {
            print("Password not matched")
        }
    }
  

}
