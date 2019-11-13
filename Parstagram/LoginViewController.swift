//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Guillermo Hernandez on 11/11/19.
//  Copyright © 2019 Guillermo Hernandez. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        self.loadingIndicator.startAnimating()
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.loadingIndicator.stopAnimating()
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.loadingIndicator.stopAnimating()
                print("\(error?.localizedDescription ?? "Unknown Error")")
                let alertController = UIAlertController(title: "Sign up Error", message:
                    "Something went wrong when loggin in :(", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        self.loadingIndicator.startAnimating()
        user.signUpInBackground { (success, error) in
            if success {
                self.loadingIndicator.stopAnimating()
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.loadingIndicator.stopAnimating()
                print("\(error?.localizedDescription ?? "Unknown Error")")
                let alertController = UIAlertController(title: "Sign up Error", message:
                    "Something went wrong when signing you up :(", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
