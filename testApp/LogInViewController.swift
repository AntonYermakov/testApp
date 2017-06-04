//
//  SignUpViewController.swift
//  testApp
//
//  Created by Yermakov Anton on 02.06.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logInBtn(_ sender: Any) {
        
        guard emailField.text != "", passwordField.text != "" else { return }
        
          FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            
            if let error = error{
                print(error.localizedDescription)
            }
            
            if let _ = user {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersVC")
                self.present(vc, animated: true, completion: nil)
            }
          })
    }

}
