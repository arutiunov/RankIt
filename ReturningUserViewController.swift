//
//  ReturningUserViewController.swift
//  MyList
//
//  Created by Artiom Arutiunov on 8/16/17.
//  Copyright © 2017 Artiom Arutiunov. All rights reserved.
//

import UIKit
import CloudKit

class ReturningUserViewController: UIViewController {
    
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    var list = [CKRecord]()
    
    @IBAction func SignIn(_ sender: UIButton) {
        list = [CKRecord]()
        let publicData = CKContainer.default().publicCloudDatabase


        let userID: String = Username.text! as String
        let userPassword: String = Password.text! as String
        let filterByUsername: NSPredicate = NSPredicate(format: "allTokens TOKENMATCHES[cdl] %@", userID)
    
        
        let queryUser = CKQuery(recordType: "User", predicate: filterByUsername)

        publicData.perform(queryUser, inZoneWith: nil)
        {(results:[CKRecord]?, error:Error?) -> Void in
            if results != nil {
                if results!.count == 0 {
                    print("database error!")
                }
                else {
//                    print("success")
                    let fetchedUserAccount = results![0]
                    let correspondingPassword = fetchedUserAccount["Password"] as! String
                    GlobalUserName = userID
//                    print (GlobalUserName)
                    if correspondingPassword == userPassword {
                        OperationQueue.main.addOperation {
                            let alertOfSuccesfulLogin = UIAlertController(title: "Login successful", message: "Welcome back! Please proceed to your list by pressing the button below.", preferredStyle: .alert)
                            alertOfSuccesfulLogin.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            alertOfSuccesfulLogin.addAction(UIAlertAction(title: "Go to my list", style: .default, handler: { action in self.performSegue(withIdentifier: "LogInToHomePage", sender: self) }))
                                                        
                            self.present(alertOfSuccesfulLogin, animated: true, completion: nil)
                        }
                    }
                    else {
                        OperationQueue.main.addOperation {
                            let alertOfUnsuccesfulLogin = UIAlertController(title: "Try again", message: "Username and/or password are incorrect! Please try again.", preferredStyle: .alert)
                            alertOfUnsuccesfulLogin.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            self.present(alertOfUnsuccesfulLogin, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
