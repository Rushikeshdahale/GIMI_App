//
//  SecondLoginViewController.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 28/12/23.
//

import UIKit
import Firebase

class SecondLoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginClicked(_ sender: UIButton) {
        
        guard let email = emailTextField.text else
        {return}
        guard let password = passwordTextField.text else
        {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }
            else{
                self.performSegue(withIdentifier: "ViewController", sender: self)
            }
        }
    }
}
