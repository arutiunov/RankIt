//
//  NewUserViewController.swift
//  MyList
//
//  Created by Artiom Arutiunov on 8/16/17.
//  Copyright © 2017 Artiom Arutiunov. All rights reserved.
//

import UIKit
import CloudKit


class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    
    @IBAction func SignUpNewUser(_ sender: UIButton) {
        let newUser = CKRecord(recordType: "User")
        newUser["UserName"] = self.UsernameTextField.text! as CKRecordValue
        newUser["Password"] = self.UserPassword.text! as CKRecordValue
        let publicData = CKContainer.default().publicCloudDatabase
        publicData.save(newUser, completionHandler: {
            (record:CKRecord?, error: Error?)-> Void in
            
            
            if error == nil {
                OperationQueue.main.addOperation {
                print("successfully created a new user")
                    let alertOfSuccessfulAccountCreation = UIAlertController(title: "Account creation successful", message: "Your account has been successfully created, please press the button below to be taken to your list", preferredStyle: .alert)
                    
                    alertOfSuccessfulAccountCreation.addAction(UIAlertAction(title:"OK", style: .default, handler:  { action in self.performSegue(withIdentifier: "SignInToHomePage", sender: self) }))

                    
//
                    alertOfSuccessfulAccountCreation.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alertOfSuccessfulAccountCreation, animated: true, completion: nil)
                }
            }
            else {
                print ("error")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UsernameTextField.delegate = self
        self.UserPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
